from datetime import datetime
from django.db import transaction
from rest_framework import serializers
from .models import Order, OrderDetail
from course.models import Course, CourseExpire

from django_redis import get_redis_connection
from coupon.models import UserCoupon
from dwdarcity_api.settings import constants


class OrderModelSerializer(serializers.ModelSerializer):
    """创建订单的序列号器"""
    class Meta:
        model = Order
        fields = ['id', 'order_number', 'pay_type', 'credit', 'coupon']
        extra_kwargs = {
            "id": {"read_only": True},
            "order_number": {"read_only": True},
            "pay_type": {"write_only": True},
            "credit": {"write_only": True},
            "coupon": {"write_only": True}
        }

    def validate(self, attrs):
        """数据校验"""
        # 校验支付类型
        pay_type = attrs.get("pay_type")
        try:
            Order.pay_choices[pay_type]
        except:
            raise serializers.ValidationError({'message': '对不起，不支持选中的支付方式'})
        # todo 判断积分使用是否上限
        # 用户的积分
        user_credit = self.context["request"].user.credit
        credit = attrs.get("credit", 0)
        if credit != 0 and user_credit < credit:
            raise serializers.ValidationError({'message': '对不起，抵扣的积分不能大于用户积分数量，无法生成订单'})

        # todo 判断优惠券是否在使用期间，是否是未使用状态
        user_coupon_id = attrs.get('coupon')

        if user_coupon_id:
            now = datetime.now()
            now_time = now.strftime("%Y-%m-%d %H:%M:%S")
            try:
                user_coupon = UserCoupon.objects.get(pk=user_coupon_id, start_time__lte=now_time, is_show=True,
                                                     is_delete=False, is_use=False)
            except:
                raise serializers.ValidationError({'message': '对不起，当前优惠券不存在或者不可用'})

            # 用户优惠券有效期
            timer_timestamp = user_coupon.coupon.timer * 24 * 60 * 60
            # 用户优惠策略的开始时间
            start_timestamp = user_coupon.start_time.timestamp()
            # 用户优惠券的结束时间
            end_timestamp = start_timestamp + timer_timestamp
            if end_timestamp < now.timestamp():
                raise serializers.ValidationError({'message': '对不起，当前优惠券已过期'})

        # 一定要return要不然
        return attrs

    def create(self, validated_data):
        """通过【实物来完成订单的生成】"""
        redis_conn = get_redis_connection('cart')
        user_id = self.context['request'].user.id
        incr = int(redis_conn.incr('order'))
        order_number = datetime.now().strftime("%Y%m%d%H%M%S") + "%06d" % user_id + "%06d" % incr

        # ********************** 通过事物生成订单

        with transaction.atomic():
            # 记录事物的回滚点
            save_id = transaction.savepoint()
            order = Order.objects.create(
                order_title="路飞学城购买课程",
                is_show=True,
                total_price=0,
                real_price=0,
                order_number=order_number,
                order_status=0,
                pay_type=validated_data.get("pay_type"),
                credit=validated_data.get("credit", 0),
                coupon=int(validated_data.get("coupon", 0)),
                order_desc="",
                user_id=user_id
            )
            # ********************** 生成订单详情
            # 获取购物车中所有商品
            cart_bytes_dict = redis_conn.hgetall('cart_%s' % user_id)
            selected_bytes_list = redis_conn.smembers('selected_%s' % user_id)

            # 开启redis事物操作
            pipe = redis_conn.pipeline()
            pipe.multi()

            # 获取勾选的商品
            for course_id_bytes, expire_id_bytes in cart_bytes_dict.items():
                # 课程id
                course_id = int(course_id_bytes.decode())
                # 课程有效期id
                expire_id = int(expire_id_bytes.decode())
                # 判断当前id是否在勾选集合中
                if course_id_bytes in selected_bytes_list:
                    try:
                        course = Course.objects.get(is_show=True, is_delete=False, pk=course_id)
                    except Course.DoesNotExist:
                        # 回滚事物（定点回滚）  - 把声明到这里的中间所有执行的sql语句执行产生的影响抹除
                        transaction.savepoint_rollback(save_id)
                        raise serializers.ValidationError({'message': '对不起，购买的商品不存在或已下架'})

                    # 判断课程有效期，获取课程原价
                    original_price = course.price
                    try:
                        if expire_id > 0:
                            courseexpire = CourseExpire.objects.get(id=expire_id)
                            original_price = courseexpire.price
                    except CourseExpire.DoesNotExist:
                        pass

                    real_price = course.real_price(expire_id)
                    # 生成订单详情
                    try:
                        OrderDetail.objects.create(
                            is_show=True,
                            order=order,
                            course=course,
                            expire=expire_id,
                            price=original_price,
                            real_price=real_price,
                            discount_name=course.discount_name
                        )
                    except:
                        # 定点回滚
                        transaction.savepoint_rollback(save_id)
                        raise serializers.ValidationError({'message': '对不起，订单生成失败'})
                    # 计算计算订单总价
                    order.total_price += float(real_price)  # 原价

                    # 从购物车中移除，已经加入到订单中的商品信息
                    pipe.hdel("cart_%s" % user_id, course_id)
                    pipe.srem("selected_%s" % user_id, course_id)

            # 保存订单
            # 默认最终实付价格等于 默认总价
            real_price = order.total_price
            try:
                # 对总价格加入优惠券折算
                user_coupon_id = validated_data.get("coupon")

                if user_coupon_id > 0:
                    user_coupon = UserCoupon.objects.get(pk=user_coupon_id)
                    if user_coupon.coupon.condition > order.total_price:
                        """如果订单的总金额比使用条件价格底！则报错"""
                        transaction.savepoint_rollback(save_id)
                        raise serializers.ValidationError({'message': '对不起，生成订单失败！总金额达不到优惠券使用条件'})

                    sale_num = float(user_coupon.coupon.sale[1:])
                    if user_coupon.coupon.sale[0] == "*":
                        """折扣优惠"""
                        real_price = order.total_price * sale_num
                    else:
                        """减免优惠"""
                        real_price = order.total_price - sale_num
                    # 订单中的使用的优惠券记录到数据库
                    order.coupon = user_coupon_id

                # 积分抵扣
                credit = validated_data.get("credit")
                if credit > 0:
                    # 判断积分是否超过订单总价格的折扣比例
                    if credit > real_price * constants.CREDIT_MONEY:
                        transaction.savepoint_rollback(save_id)
                        raise serializers.ValidationError({'message': '对不起，生成订单失败！当前抵扣积分超出了使用上限'})
                    real_price = float("%.2f" % (real_price - credit / constants.CREDIT_MONEY))
                    order.credit = credit

                order.real_price = real_price
                # 保存订单数据
                order.save()
                # 执行redis事物，从购物车中删除已勾选商品
                pipe.execute()
            except:
                transaction.savepoint_rollback(save_id)
                raise serializers.ValidationError({'message': '对不起，订单保存失败'})

        # 返回订单模型结果[记录本次下单的所有商品信息]
        return order
