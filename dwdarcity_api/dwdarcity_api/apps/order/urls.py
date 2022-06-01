from django.urls import path
from . import views

urlpatterns = [
    path(r'',views.OrderAPIView.as_view()),
]