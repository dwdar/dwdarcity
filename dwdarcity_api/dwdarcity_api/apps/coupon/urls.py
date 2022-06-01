from django.urls import path
from . import views

urlpatterns = [
    path(r'',views.UserCouponListAPIView.as_view()) 
]