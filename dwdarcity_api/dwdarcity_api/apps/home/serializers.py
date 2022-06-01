from rest_framework import serializers
from .models import Banner
from .models import Nav


class BannerModelSerializer(serializers.ModelSerializer):
    """轮播图广告序列化器"""

    class Meta:
        model = Banner
        fields = ['image_url', 'link']


class HeanderNavModelSerializer(serializers.ModelSerializer):
    """头部导航序列化器"""

    class Meta:
        model = Nav
        fields = ['title', 'link', 'is_site']
