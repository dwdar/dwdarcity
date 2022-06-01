from rest_framework.views import APIView
from alipay import AliPay
from django.conf import settings
from rest_framework.response import Response
from rest_framework import status
import logging
from django.http.response import HttpResponse

log = logging.getLogger("django")
from order.models import Order
from coupon.models import UserCoupon
from user.models import UserCourse
from course.models import CourseExpire
from datetime import datetime
from django.db import transaction

# 读取秘钥和公公钥信息
app_private_key_string = open(settings.ALIPAY_CONFIG["app_private_key_path"]).read()
alipay_public_key_string = open(settings.ALIPAY_CONFIG["alipay_public_key_path"]).read()


class AlipayAPIView(APIView):
    """支付宝支付接口"""

    def get(self, request):
        # 获取订单号
        order_number = request.query_params.get("order_number")
        # 判断订单是否存在
        try:
            order = Order.objects.filter(order_number=order_number, is_show=True, is_delete=False, order_status=0,
                                         pay_type=0, real_price__gt=0).first()
        except Order.DoesNotExist:
            return Response({"message": "对不起订单不存在"}, status=status.HTTP_400_BAD_REQUEST)

        # 初始化支付对象
        alipay = AliPay(
            appid=settings.ALIPAY_CONFIG["appid"],
            app_notify_url=settings.ALIPAY_CONFIG["app_notify_url"],  # 默认回调 url
            app_private_key_string=app_private_key_string,
            # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            alipay_public_key_string=alipay_public_key_string,
            sign_type=settings.ALIPAY_CONFIG["sign_type"],  # RSA 或者 RSA2
            debug=settings.ALIPAY_CONFIG["debug"],  # 默认 False
            verbose=False,  # 输出调试数据
            # config=AliPayConfig(timeout=15)  # 可选，请求超时时间
        )

        # 调用支付接口
        # 电脑网站支付，需要跳转到：https://openapi.alipay.com/gateway.do? + order_string
        order_string = alipay.api_alipay_trade_page_pay(
            out_trade_no=order.order_number,
            total_amount=float(order.real_price),
            subject=order.order_title,
            return_url=settings.ALIPAY_CONFIG["return_url"],
            notify_url=settings.ALIPAY_CONFIG["notify_url"]  # 可选，不填则使用默认 notify url
        )
        url = settings.ALIPAY_CONFIG["gateway_url"] + "?" + order_string

        return Response(url)


class AliPayResultAPIView(APIView):

    def get(self, request):
        """处理支付宝同步通知结果"""

        alipay = AliPay(
            appid=settings.ALIPAY_CONFIG["appid"],
            app_notify_url=settings.ALIPAY_CONFIG["app_notify_url"],  # 默认回调 url
            app_private_key_string=app_private_key_string,
            # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            alipay_public_key_string=alipay_public_key_string,
            sign_type=settings.ALIPAY_CONFIG["sign_type"],  # RSA 或者 RSA2
            debug=settings.ALIPAY_CONFIG["debug"],  # 默认 False
            verbose=False,  # 输出调试数据
            # config=AliPayConfig(timeout=15)  # 可选，请求超时时间
        )

        data = request.query_params.dict()

        signature = data.pop("sign")

        # verification
        success = alipay.verify(data, signature)

        if success:
            # 补充支付成功后的业务代码
            return self.change_order_status(data)
        return Response({"message": "对不起,当前订单支付失败或订单支付结果更新失败"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def post(self, request):
        print("支付宝的post请求来了")
        """处理支付宝异步通知结果"""
        alipay = AliPay(
            appid=settings.ALIPAY_CONFIG["appid"],
            app_notify_url=settings.ALIPAY_CONFIG["app_notify_url"],  # 默认回调 url
            app_private_key_string=app_private_key_string,
            # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            alipay_public_key_string=alipay_public_key_string,
            sign_type=settings.ALIPAY_CONFIG["sign_type"],  # RSA 或者 RSA2
            debug=settings.ALIPAY_CONFIG["debug"],  # 默认 False
            verbose=False,  # 输出调试数据
            # config=AliPayConfig(timeout=15)  # 可选，请求超时时间
        )

        data = request.data
        signature = data.pop("sign")
        success = alipay.verify(data, signature)
        if success and data["trade_status"] in ("TRADE_SUCCESS", "TRADE_FINISHED"):
            # 确认后台是否根据同步支付宝同步通知完成了支付成功后的订单更新业务
            trade_no = data.get("trade_no")
            user_course = UserCourse.objects.filter(trado_no=trade_no).first()

            # 如果已完成了支付成功后的订单更新业务，则返回success给支付宝
            if user_course:
                return HttpResponse("success")
            # 如果没有完成支付成功后的订单更新业务，则完成支付成功后的订单更新业务
            # 补充支付成功后的业务代码
            response = self.change_order_status(data)
            if "credit" in response.data:
                return HttpResponse("success")

        return Response({"message": "对不起,当前订单支付失败或订单支付结果更新失败"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def change_order_status(self, data):
        """同步直接结果通知"""
        order_number = data.get("out_trade_no")
        try:
            order = Order.objects.get(order_number=order_number, is_show=True, is_delete=False, order_status=0,
                                      pay_type=0, real_price__gt=0)
        except Order.DoesNotExist:
            return Response({"message": "对不起,支付失败，订单不存在"}, status=status.HTTP_400_BAD_REQUEST)

        with transaction.atomic():
            save_id = transaction.savepoint()
            # 1.更新订单状态即可
            try:
                # 2.记录支付时间
                order.pay_time = datetime.now()
                order.order_status = 1
                order.save()
                # 3.如果有使用优惠券或者积,则修改优惠券的使用状态和扣除积分
                # 3.1 该订单有优惠券信息则修改优惠券状态
                # 3.2 该订单如果有
                user_coupon_id = order.coupon
                if user_coupon_id > 0:
                    user_coupon = UserCoupon.objects.get(pk=user_coupon_id, is_use=False, is_show=True, is_delete=False)
                    user_coupon.is_use = True
                    user_coupon.save()
                # 4.记录用户成功购买课程的记录，增加课程的购买人数
                credit = order.credit
                user = order.user
                if credit > 0:
                    user.credit -= credit
                    user.save()

                # 本订单购买的所有课程
                order_detail_list = order.order_courses.all()
                course_list = []
                for order_detail in order_detail_list:
                    """循环获取本次订单中所有购买的商品课程"""
                    # 课程学习人数 +1
                    course = order_detail.course
                    course.students += 1
                    course.save()
                    # 课程有效期计算
                    pay_timestamp = order.pay_time.timestamp()  # 购买时间戳
                    # 如果课程有时间限制，计算有效时间
                    if order_detail.expire > 0:
                        # 有效期间购买
                        expire = CourseExpire.objects.get(pk=order_detail.expire)
                        expire_timestamp = expire.expire_time * 24 * 60 * 60
                        out_time = datetime.fromtimestamp(pay_timestamp + expire_timestamp)
                    else:
                        # 永久购买
                        out_time = None
                    # 添加用户课程购买记录数据
                    UserCourse.objects.create(
                        user=user,
                        course=course,
                        trado_no=data.get("trade_no"),
                        buy_type=1,
                        pay_time=order.pay_time,
                        out_time=out_time,
                        is_show=True,
                    )
                    course_list.append({
                        "id": course.id,
                        "name": course.name
                    })
            except:
                log.error("订单结果处理出现故障，无法记录订单的相关记录状态")
                transaction.savepoint_rollback(save_id)
                return Response({"message": "对不起,支付失败，更新订单信息失败"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        # 返回结果

        return Response({
            "message": "支付成功",
            "credit": user.credit,
            "pay_time": order.pay_time,
            "real_price": order.real_price,
            "course_list": course_list
        })


"""
买家信息
买家账号cfdcrq0560@sandbox.com
登录密码111111
支付密码111111
"""
