from rest_framework.generics import ListAPIView
from rest_framework.views import APIView
from .models import CourseCategory
from .serializers import CourseCategoryModelSerializer
from .serializers import CourseListModelSerializer
from .models import Course
from .models import CourseChapter
from .serializers import CourseChapterListModelSerializer

from rest_framework.generics import RetrieveAPIView
from .serializers import CourseRetrieveModelSerializer


# Create your views here.
class CourseCategoryListAPIView(ListAPIView):
    """
    课程分来
    """
    queryset = CourseCategory.objects.filter(is_show=True, is_delete=False).order_by('orders', 'id')
    serializer_class = CourseCategoryModelSerializer


"""2022-04-03"""
# DRF 提供的筛选过滤器（需要pip安装)
from django_filters.rest_framework import DjangoFilterBackend
# DRF 提供的排序过滤器
from rest_framework.filters import OrderingFilter
# DRF 分页功能
from rest_framework.pagination import PageNumberPagination
# 分页器类
from .paginations import CoursePageNumberPagination


class CourseListAPIView(ListAPIView):
    """
    课程列表v2
    """
    queryset = Course.objects.filter(is_show=True, is_delete=False).order_by('orders', 'id')
    serializer_class = CourseListModelSerializer
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filter_fields = ['course_category', ]
    ordering_fields = ('id', 'students', 'price')
    pagenation = PageNumberPagination
    pagination_class = CoursePageNumberPagination


class CourseRetrieveAPIView(RetrieveAPIView):
    queryset = Course.objects.filter(is_show=True, is_delete=False).order_by('orders', 'id')
    serializer_class = CourseRetrieveModelSerializer


class CourseChapterListAPIView(ListAPIView):
    """课程章节试图"""
    queryset = CourseChapter.objects.filter(is_show=True, is_delete=False).order_by('orders', 'id')
    serializer_class = CourseChapterListModelSerializer
    filter_backends = [DjangoFilterBackend]
    filter_fields = ['course']


"""2022-05-08"""
from dwdarcity_api.libs.polyv import PolyvPlayer
from rest_framework.permissions import IsAuthenticated
from django.conf import settings
from rest_framework.response import Response


class PolyvAPIView(APIView):
    """保利威视频播放"""
    permission_classes = [IsAuthenticated]
    def get(self, request):
        """获取视频播放的token"""
        userId = settings.POLYV_CONFIG["userId"]
        secretkey = settings.POLYV_CONFIG["secretkey"]
        tokenUrl = settings.POLYV_CONFIG["tokenUrl"]
        polyv = PolyvPlayer(userId, secretkey, tokenUrl)

        vid = request.query_params.get("vid")  # 视频ID
        user_ip = request.META.get("REMOTE_ADDR")  # 用户IP
        user_id = request.user.id  # 用户id
        user_name =  request.user.username  # 用户名
        result = polyv.get_video_token(vid, user_ip, user_id, user_name)

        return Response(result.get("token"))
