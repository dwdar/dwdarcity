from rest_framework.generics import ListAPIView
from .models import UserCoupon
from .serializers import UserCouponModelSerializer
from rest_framework.permissions import IsAuthenticated

class UserCouponListAPIView(ListAPIView):
	"""用户优惠券列表"""
	
	serializer_class = UserCouponModelSerializer
	permission_classes = [IsAuthenticated]

	def get_queryset(self):
		# 获取当前用户! 在确定用户登录以后，可以通过视图对象本身获取 request对象
		user  = self.request.user
		queryset = UserCoupon.objects.filter(is_show=True,is_delete=False,is_use=False,user=user).order_by('orders','id')
		return queryset

