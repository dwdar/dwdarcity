from django.urls import path
from . import views

urlpatterns = [
    # 提供支付宝支付页面视图
    path(r'alipay/', views.AlipayAPIView.as_view()),
    # 记录支付宝支付结果视图
    path(r'alipay/result/', views.AliPayResultAPIView.as_view()),
]
