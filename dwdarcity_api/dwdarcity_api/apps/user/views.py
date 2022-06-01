import re
import random
from django.contrib.auth.hashers import make_password
from django_redis import get_redis_connection
from rest_framework.views import APIView
from rest_framework.generics import ListAPIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework_jwt.serializers import jwt_payload_handler
from rest_framework_jwt.utils import jwt_encode_handler
from rest_framework.permissions import IsAuthenticated

from dwdarcity_api.settings import constants
import logging

from mycelery.sms.tasks import send_sms
from mycelery.mail.tasks import send_to_mail

# Create your views here.
from rest_framework.generics import CreateAPIView
from .models import User
from .serializers import UserModelSerializer
from .utils import get_user_by_account

from order.models import Order
from user.models import UserCourse

from .serializers import UserOrderModelSerializer
from .serializers import UserCourseModelSerializer


class UserAPIView(CreateAPIView):
    """用户信息视图"""
    queryset = User.objects.all()
    serializer_class = UserModelSerializer


class MobileAPIView(APIView):
    """手机号码唯一性校验"""

    def get(self, request, mobile):
        if not re.match(r"^1[3-9]\d{9}$", mobile):
            return Response({"message": "手机号格式错误"}, status=status.HTTP_400_BAD_REQUEST)

        ret = get_user_by_account(mobile)
        if ret is not None:
            return Response({"message": "手机号已使用"}, status=status.HTTP_400_BAD_REQUEST)
        return Response(status=status.HTTP_200_OK)


log = logging.getLogger("django")


class SMSAPIView(APIView):

    def get(self, request, mobile):
        """短信发送接口"""
        # 1、 判断手机号码是否在60秒内曾经发送过短信
        redis_conn = get_redis_connection("sms_code")
        # 从redis中查找数据库
        ret = redis_conn.get("mobile_%s" % mobile)

        if ret is not None:
            return Response({'message': '短信已经发送，请耐心等待!,60秒内只能发送一次'}, status=status.HTTP_400_BAD_REQUEST)

        # 2、 先生成短信验证码
        sms_code = "%06d" % random.randint(1, 999999)

        # 3、 保存短信验证码到redis[使用事物把多条命令发送给redis]
        # 3.1 创建管道对象
        pipe = redis_conn.pipeline()
        # 3.2 开启事物【事物无法管理数据库的读取数据操作】
        pipe.multi()
        # 3.3 将操作命令放到事物当中
        pipe.setex("sms_%s" % mobile, constants.SMS_INTERVAL_TIME, sms_code)
        pipe.setex("mobile_%s" % mobile, constants.SMS_INTERVAL_TIME, '_')
        # 3.4 执行事物
        pipe.execute()
        # 4、调用短信SDK,发送短信
        try:
            # 异步发送短信
            send_sms.delay(mobile, sms_code)
            # print('手机短信模拟', mobile, sms_code)
        except:
            return Response({'message': '短信发送失败！'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        # 5、相应发送短信的结构
        return Response({'message': '短信发送成功'}, status=status.HTTP_200_OK)


class MAILAPIView(APIView):
    """发送邮件"""

    def get(self, request, *args, **kwargs):
        """验证邮箱是否绑定"""
        email = kwargs.get('mail')
        ret = get_user_by_account(email)
        if ret is None:
            return Response({"message": "该邮箱未绑定用户"}, status=status.HTTP_400_BAD_REQUEST)
        self.is_email = True
        return Response(status=status.HTTP_200_OK)

    def post(self, request, *args, **kwargs):
        """发送验证到到用户邮箱"""
        mail = kwargs.get('mail')
        if not mail:
            return Response({'message': '邮箱格式错误或未填写'}, status=status.HTTP_400_BAD_REQUEST)
        # 1、 判断手机号码是否在60秒内曾经发送过邮件
        # 1.1 链接数据库
        redis_conn = get_redis_connection("mail_code")
        # 1.2 查询数据
        ret = redis_conn.get("mail_%s" % mail)
        # 1.3 判断是否发送过邮件
        if ret is not None:
            return Response({'message': '邮件已经发送，请耐心等待!,60秒内只能发送一次'}, status=status.HTTP_400_BAD_REQUEST)

        # 2.创建邮箱验证码
        mail_code = "%06d" % random.randint(1, 999999)

        # 将邮箱验证码保存到redis缓存数据库
        # 3.1 创建管道对象
        pipe_mail = redis_conn.pipeline()
        # 3.2 开启事物【事物无法管理数据库的读取数据操作】
        pipe_mail.multi()
        # 3.3 将操作命令放到事物当中
        pipe_mail.setex("code_%s" % mail, constants.SMS_INTERVAL_TIME, mail_code)
        pipe_mail.setex("mail_%s" % mail, constants.SMS_INTERVAL_TIME, "-")
        # 3.4 执行事物
        pipe_mail.execute()

        # 4、调用celery异步任务发送邮件
        try:
            # 4.1 delay异步任务
            send_to_mail.delay(mail, mail_code)

        except:
            return Response({'message': '邮件发送失败！'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        # 5、相应发送短信的结构
        return Response({'message': '邮件发送成功'}, status=status.HTTP_200_OK)


class SmsLoginView(APIView):
    """短信登录"""

    def get(self, request, *args, **kwargs):
        mobile = kwargs.get('mobile')
        sms_code = kwargs.get('sms')

        redis_conn = get_redis_connection("sms_code")
        # redis中获取验证码
        real_sms_code = redis_conn.get("sms_%s" % mobile)

        if real_sms_code is None:
            return Response({'message': '登录失败,短信验证码错误'}, status=status.HTTP_400_BAD_REQUEST)

        # 错误之后 将短信验证码删除掉，避免暴力破解
        redis_conn.delete("sms_%s" % mobile)

        if real_sms_code.decode() != sms_code:
            return Response({'message': '登录失败,短信验证码错误'}, status=status.HTTP_400_BAD_REQUEST)

        user = get_user_by_account(mobile)

        if user is None:
            return Response({'message': '未找到该用户'}, status=status.HTTP_400_BAD_REQUEST)

        if user is not None:
            # 手动生成token
            payload = jwt_payload_handler(user)
            user.token = jwt_encode_handler(payload)

            data = {
                'id': user.id,
                'username': user.username,
                'token': user.token
            }
            return Response(data, status=status.HTTP_200_OK, )


class ValidmailAPIView(APIView):
    """验证邮箱验证码是否真是"""

    def get(self, request, *args, **kwargs):
        """验证邮箱验证码是否真是"""
        # 1.链接redis
        redis_conn = get_redis_connection("mail_code")
        # 2.获取前段信息
        email = kwargs.get('email')
        email_code = kwargs.get('email_code')

        # 3. 查询数据库中存储的验证码
        real_mail_code = redis_conn.get("code_%s" % email)

        if real_mail_code is None:
            return Response({'message': '登录失败,短信验证码错误'}, status=status.HTTP_400_BAD_REQUEST)
        # 4. 比对两个验证码是否一致
        if real_mail_code.decode() != email_code:
            return Response({'message': '登录失败,短信验证码错误'}, status=status.HTTP_400_BAD_REQUEST)
        # 5.查询该用户信息
        user = get_user_by_account(email)
        if user is None:
            return Response({'message': '未找到该用户'}, status=status.HTTP_400_BAD_REQUEST)

        # 6.手动生成token
        payload = jwt_payload_handler(user)
        user.token = jwt_encode_handler(payload)

        # 7.将token存储到redis
        # 7.1 创建管道对象
        pipe_token = redis_conn.pipeline()
        # 7.2 开启事物【事物无法管理数据库的读取数据操作】
        pipe_token.multi()
        # 7.3 将操作命令放到事物当中
        pipe_token.setex("token_%s" % user, constants.SMS_INTERVAL_TIME, user.token)
        # 7.4 执行事物
        pipe_token.execute()

        # 8.返回用户数据到前段
        data = {
            'id': user.id,
            'username': user.username,
            'token': user.token
        }
        return Response(data, status=status.HTTP_200_OK)


class RePasswordAPIView(APIView):
    """重置密码"""

    def post(self, request, *args, **kwargs):
        # 1. 接收前段发过来的用户信息（用户名，token,新密码）
        username = request.data.get('username')
        newpassword = request.data.get('newpassword')
        renewpassword = request.data.get('renewpassword')
        token = request.data.get('token')
        # 2. 查询该用户获取用户对象

        if not newpassword:
            return Response({'message': '密码不能为空'}, status=status.HTTP_400_BAD_REQUEST)

        if newpassword != renewpassword:
            return Response({'message': '两次输入的密码不一致'}, status=status.HTTP_400_BAD_REQUEST)

        user = get_user_by_account(username)
        if user is None:
            return Response({'message': '未找到该用户'}, status=status.HTTP_400_BAD_REQUEST)

        # 4. 验证token
        redis_conn = get_redis_connection("mail_code")
        real_token = redis_conn.get("token_%s" % user)

        if real_token is None:
            return Response({'message': '验证超时！'}, status=status.HTTP_403_FORBIDDEN)

        # 错误之后 将短信验证码删除掉，避免暴力破解
        redis_conn.delete("token_%s" % user)

        # 4. 比对两个验证码是否一致
        if real_token.decode() != token:
            return Response({'message': '验证超时！'}, status=status.HTTP_403_FORBIDDEN)
        else:
            # 5. 修改密码返回结果
            user.password = make_password(newpassword)
            user.save()
            return Response({'message': '密码修改成功！'}, status=status.HTTP_200_OK)


class UserOrderListAPIView(ListAPIView):
    """用户订单视图"""
    permission_classes = [IsAuthenticated]
    serializer_class = UserOrderModelSerializer

    def get_queryset(self):
        user = self.request.user
        order = Order.objects.filter(is_show=True, is_delete=False, user=user).order_by('-id')
        return order


class UserCourseListAPIView(ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = UserCourseModelSerializer

    def get_queryset(self):
        user = self.request.user # User.objects.filter(id=2).first()  #
        return UserCourse.objects.filter(user=user, is_delete=False, is_show=True).order_by("orders", "id")
