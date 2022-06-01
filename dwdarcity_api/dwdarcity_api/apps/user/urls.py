from django.urls import path, re_path
from rest_framework_jwt.views import obtain_jwt_token
from . import views

urlpatterns = [
    path(r'login/', obtain_jwt_token),
    path(r'reg/', views.UserAPIView.as_view()),
    re_path(r'^mobile/(?P<mobile>\d+)/$', views.MobileAPIView.as_view()),
    re_path(r'^sms/(?P<mobile>\d+)/$', views.SMSAPIView.as_view()),
    re_path(r'^mail/(?P<mail>.*)/$', views.MAILAPIView.as_view()),
    re_path(r'^sms_login/(?P<mobile>\d+)/(?P<sms>\d+)/$', views.SmsLoginView.as_view()),
    re_path(r'^validmail/(?P<email>.*)/(?P<email_code>\d+)/$', views.ValidmailAPIView.as_view()),
    path(r'repassword/', views.RePasswordAPIView.as_view()),
    # 用户订单
    path(r'order/', views.UserOrderListAPIView.as_view()),
    # 用户课程
    path(r'course/', views.UserCourseListAPIView.as_view()),
]
