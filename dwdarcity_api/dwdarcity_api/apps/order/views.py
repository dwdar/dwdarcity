from rest_framework.generics import CreateAPIView
from .models import Order
from .serializers import OrderModelSerializer
from rest_framework.permissions import IsAuthenticated

# Create your views here.
class OrderAPIView(CreateAPIView):
    """订单模型"""
    queryset = Order.objects.filter(is_show=True,is_delete=False)
    serializer_class = OrderModelSerializer
    permission_classes = [IsAuthenticated]
