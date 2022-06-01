from rest_framework.viewsets import ViewSet
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from course.models import Course
from course.models import CourseExpire
from rest_framework.response import Response
from rest_framework import status
from django_redis import get_redis_connection
import logging
from dwdarcity_api.settings import constants

log = logging.getLogger("django")


class CartAPIView(ViewSet):
    """购物车"""
    permission_classes = [IsAuthenticated]

    def add(self, request):
        """添加商品到购物车中"""

        # 接受客户端提交参数[用户ID，课程ID，勾选状态，有效期选项]
        course_id = request.data.get("course_id")
        user_id = request.user.id
        # 设置默认值
        selected = True
        expire = 0
        try:
            course = Course.objects.get(is_show=True, is_delete=False, id=course_id)
        except Course.DoesNotExist:
            return Response({"message": "参数有误！课程不存在！"}, status=status.HTTP_400_BAD_REQUEST)

        # 获取redis连接对象
        redis_conn = get_redis_connection("cart")
        # 保存数据到redis
        try:
            pipe = redis_conn.pipeline()
            pipe.multi()
            pipe.hset("cart_%s" % user_id, course_id, expire)
            pipe.sadd("selected_%s" % user_id, course_id)
            pipe.execute()

            # 查询购物车中商品总数
            course_len = redis_conn.hlen("cart_%s" % user_id)

        except:
            log.error("购物车数据存储错误！")
            return Response({"message": "参数有误！购物车添加商品失败！"}, status=status.HTTP_507_INSUFFICIENT_STORAGE)

        # 返回结果[当前购物车中商品总数]
        return Response({"message": "购物车商品添加成功！", "cart_length": course_len})

    def list(self, request):
        """购物车中的商品列表"""
        user_id = request.user.id

        # 从redis 中读取数据
        redis_conn = get_redis_connection("cart")
        cart_bytes_dict = redis_conn.hgetall('cart_%s' % user_id)
        selected_bytes_list = redis_conn.smembers('selected_%s' % user_id)

        # 使用循环从mysql中根据对应商品信息，商品id，商品封面图片，商品标题

        data = []

        for course_id_bytes, expire_id_bytes in cart_bytes_dict.items():
            # 课程id
            course_id = int(course_id_bytes.decode())
            # 课程有效期id
            expire_id = int(expire_id_bytes.decode())

            try:
                course = Course.objects.get(is_show=True, is_delete=False, pk=course_id)
            except Course.DoesNotExist:
                continue
            data.append({
                'id': course.id,
                'selected': True if course_id_bytes in selected_bytes_list else False,
                'course_img': constants.SERVER_IMAGE_DOMAIN + course.course_img.url,
                'name': course.name,
                'expire_id': expire_id,
                'expire_list': course.expire_list,
                'price': course.real_price(expire_id)
            })
        return Response(data)

    def change_selected(self, request):
        """切换购物车商品勾选状态"""

        user_id = request.user.id

        course_id = request.data.get('course_id')

        selected = request.data.get('selected')
        try:
            course = Course.objects.get(is_show=True, is_delete=False, id=course_id)
        except Course.DoesNotExist:
            return Response({'message': '参数有误，课程信息不存在'}, status=status.HTTP_400_BAD_REQUEST)

        redis_conn = get_redis_connection('cart')

        if selected:
            redis_conn.sadd('selected_%s' % user_id, course_id)
        else:
            redis_conn.srem('selected_%s' % user_id, course_id)

        return Response({'message': '操作成功'})

    def change_expire(self, request):
        """切换购物车商品的勾选状态"""
        user_id = request.user.id
        expire_id = request.data.get("expire_id")
        course_id = request.data.get("course_id")
        try:
            # 判断课程是否存在
            course = Course.objects.get(is_show=True, is_delete=False, id=course_id)
            # 判断课程的有效期选项是0还是其他的数值，如果是其他数值，还要判断是否存在于有效期选项表中
            if expire_id > 0:
                epxire_item = CourseExpire.objects.filter(is_show=True, is_delete=False, id=expire_id)
                if not epxire_item:
                    raise Course.DoesNotExist()
        except Course.DoesNotExist:
            return Response({"message": "参数有误！当前商品课程不存在或者不能存在的有效期！"}, status=status.HTTP_400_BAD_REQUEST)

        redis_conn = get_redis_connection("cart")
        redis_conn.hset("cart_%s" % user_id, course_id, expire_id)

        # 切换了有效期选项之后重新计获取价格
        real_price = course.real_price(expire_id)

        return Response({"message": "切换课程有效期成功!", "real_price": real_price})

    def del_cart(self, request):
        """删除购物车中的商品信息"""
        # 获取参数[user_id,course_id]
        user_id = request.user.id
        course_id = request.query_params.get("course_id")
        try:
            course = Course.objects.get(is_show=True, is_delete=False, pk=course_id)
        except Course.DoesNotExist:
            return Response({"message": "对不起，当前商品已下架或不存在！"}, status=status.HTTP_400_BAD_REQUEST)

        # 连接redis，根据用户ID，删除对应用户的购物车中指定商品ID的信息
        try:
            redis = get_redis_connection("cart")
            pip = redis.pipeline()
            pip.multi()
            # 删除hash里面的购物车商品信息
            pip.hdel("cart_%s" % user_id, course_id)

            # 删除set里面的商品勾选状态
            pip.srem("selected_%s" % user_id, course_id)

            # 执行管道中的命令
            pip.execute()
        except:
            log.error("redis数据库操作出错！")
            return Response({"message": "对不起，切换商品勾选状态有误！请联系客服工作人员！"}, status=status.HTTP_507_INSUFFICIENT_STORAGE)

        # 返回结果
        return Response({"message": "删除商品成功！"}, status=status.HTTP_204_NO_CONTENT)

    def get_selected_course(self, request):
        """获取购物车中的商品列表"""

        # 获取用户id
        user_id = request.user.id

        # 链接redis链接
        redis_conn = get_redis_connection('cart')
        # 获取购物车中所有商品
        cart_bytes_dict = redis_conn.hgetall('cart_%s' % user_id)
        selected_bytes_list = redis_conn.smembers('selected_%s' % user_id)

        data = []  # 商品列表
        total_price = 0  # 勾选商品的总价格
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
                    continue

                # 判断课程有效期，获取课程原价
                original_price = course.price
                expire_text = '永久有效'
                try:
                    if expire_id > 0:
                        courseexpire = CourseExpire.objects.get(id=expire_id)
                        original_price = courseexpire.price
                        expire_text = courseexpire.expire_text
                except CourseExpire.DoesNotExist:
                    pass

                real_price = course.real_price(expire_id)

                data.append({
                    'course_img': constants.SERVER_IMAGE_DOMAIN + course.course_img.url,
                    'name': course.name,
                    'expire_text': expire_text,
                    'discount_name': course.discount_name,
                    'real_price': real_price,
                    'orginal_price': "%.2f" % original_price
                })

                total_price += float(real_price)

        # 返回结果
        return Response({'course_list': data, 'total_price': total_price})


class BuyNowAPIView(APIView):
    """立即购买课程列表"""

    # permission_classes = [IsAuthenticated]

    def get(self, request):
        # 验证登录
        # 前段获取课程id
        course_id = request.query_params.get("course_id")
        # from dwdarcity_api.apps.course.models import Course
        course = Course.objects.filter(pk=course_id, is_show=True, is_delete=False).first()
        if not course:
            return Response({'message': "课程未找到"}, status=status.HTTP_404_NOT_FOUND)

        # 有效期：默认为永久有效
        expire_text = "永久有效"
        # 获取课程价格（列表页限时的价格，有限时优惠则价格
        total_price = course.real_price()
        # 返回数据 course_list,total_price
        data = {
            'course_img': constants.SERVER_IMAGE_DOMAIN + course.course_img.url,
            'name': course.name,
            'expire_text': expire_text,
            'discount_name': course.discount_name,
            'real_price': total_price,
            'orginal_price': course.price
        }
        return Response([data])
