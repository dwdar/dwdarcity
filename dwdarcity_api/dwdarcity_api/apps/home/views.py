from django.shortcuts import render

# Create your views here.
from rest_framework.generics import ListAPIView
from .models import Banner
from .models import Nav
from .serializers import BannerModelSerializer
from dwdarcity_api.settings import constants
from .serializers import HeanderNavModelSerializer


class BannerListAPIView(ListAPIView):  # 自动导包
    """轮播广告"""
    queryset = Banner.objects.filter(is_delete=False, is_show=True).order_by('orders', '-id')[:constants.BANNER_LENGTH]
    serializer_class = BannerModelSerializer


class HeaderNavListAPIView(ListAPIView):
    """头部导航菜单试图"""
    queryset = Nav.objects.filter(is_delete=False, is_show=True, position=1).order_by('orders', '-id')[:constants.HEADER_NAV_LENGTH]
    serializer_class = HeanderNavModelSerializer

class FooterNavListAPIView(ListAPIView):
    """底部导航菜单试图"""
    queryset = Nav.objects.filter(is_delete=False, is_show=True, position=2).order_by('orders', '-id')[:constants.FOOTER_NAV_LENGTH]
    serializer_class = HeanderNavModelSerializer
