from django.urls import path
from . import views

urlpatterns = [
    path(r'', views.CartAPIView.as_view(
        {
            'post': 'add',
            'get': 'list',
            'patch': 'change_selected',
            'put': 'change_expire',
            'delete': 'del_cart'

        })),

    path(r'order/', views.CartAPIView.as_view({'get': 'get_selected_course', })),
    path(r'buynow/', views.BuyNowAPIView.as_view())

]
