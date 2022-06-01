from rest_framework import serializers
from .models import User
import re
from .utils import get_user_by_account
from django.contrib.auth.hashers import make_password

from rest_framework_jwt.settings import api_settings
from django_redis import get_redis_connection
from order.models import Order
from order.models import OrderDetail
from user.models import UserCourse
from course.models import Course
from course.serializers import CourseCategoryModelSerializer


class UserModelSerializer(serializers.ModelSerializer):
    """用户信息序列化器"""
    sms_code = serializers.CharField(min_length=4, max_length=6, required=True, write_only=True, help_text="短信验证码")
    token = serializers.CharField(max_length=1024, read_only=True, help_text="token认证字符串")

    class Meta:
        model = User
        fields = ["id", "username", "mobile", "password", "sms_code", "token"]
        extra_kwargs = {
            "id": {
                "read_only": True,
            },
            "username": {
                "read_only": True,
            },
            "password": {
                "write_only": True,
            },
            "mobile": {
                "write_only": True,
            }
        }

    def validate(self, attrs):
        mobile = attrs.get("mobile")
        sms_code = attrs.get("sms_code")
        password = attrs.get("password")
        # 验证手机号码的格式
        if not re.match(r"^1[3-9]\d{9}$", mobile):
            raise serializers.ValidationError("对不起，手机号格式有误！")

        # 验证码手机号是否已经被注册过了
        ret = get_user_by_account(mobile)
        if ret is not None:
            raise serializers.ValidationError("对不起，手机号已经被注册过！")

        # 验证短信验证码是否正确
        # 链接redis
        redis_conn = get_redis_connection("sms_code")
        # redis中获取验证码
        real_sms_code = redis_conn.get("sms_%s" % mobile)

        if not real_sms_code:
            raise serializers.ValidationError("对不起，验证码找不到了！")

        # 错误之后 将短信验证码删除掉，避免暴力破解
        redis_conn.delete("sms_%s" % mobile)

        if real_sms_code.decode() != sms_code:
            raise serializers.ValidationError("对不起!短信验证码错误！本次验证码已失效！！")
        return attrs

    def create(self, validated_data):
        """用户信息"""
        # 移除掉不需要的数据
        validated_data.pop("sms_code")
        # 对密码进行加密
        raw_password = validated_data.get("password")
        hash_password = make_password(raw_password)
        # 对用户名设置一个默认值
        username = validated_data.get("mobile")
        # 调用序列化器提供的create方法
        user = User.objects.create(
            mobile=username,
            username=username,
            password=hash_password,
        )
        # 使用 restframework_jwt提供提供手动生成token的方法生成状态
        jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER
        jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER

        payload = jwt_payload_handler(user)
        user.token = jwt_encode_handler(payload)
        return user


class UserOrderModelSerializer(serializers.ModelSerializer):
    """用户订单模型序列化器"""

    class Meta:
        model = Order
        fields = ["id", "order_number", "create_time", "order_status", "course_list"]


from course.models import CourseChapter
from course.models import CourseLesson


class CourseSectionsModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = CourseLesson
        fields = ["id","name","chapter","lesson","section_link","duration","free_trail"]


class CourseChaptersModelSerializer(serializers.ModelSerializer):
    coursesections = CourseSectionsModelSerializer(many=True)

    class Meta:
        model = CourseChapter
        fields = ["id", "name", "chapter", "coursesections"]


class CourseListModelSerializer(serializers.ModelSerializer):
    """课程列表序列化器"""
    course_category = CourseCategoryModelSerializer()
    coursechapters = CourseChaptersModelSerializer(many=True)

    class Meta:
        model = Course
        fields = ['id', "course_category", 'name', 'lessons', "coursechapters"]


couse_category_dict = {}


class UserCourseModelSerializer(serializers.ModelSerializer):
    """用户购买的课程信息序列化器"""
    course = CourseListModelSerializer()

    class Meta:
        model = UserCourse
        fields = ["id", "out_time", "course"]
