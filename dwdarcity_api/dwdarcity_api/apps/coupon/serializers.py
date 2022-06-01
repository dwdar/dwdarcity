from rest_framework import serializers
from .models import UserCoupon
from .models import Coupon

class CouponModelSerializer(serializers.ModelSerializer):
	"""优惠券序列化器"""
	class Meta:
		model = Coupon
		fields = ["id","name","coupon_type","timer","condition","sale"]


class UserCouponModelSerializer(serializers.ModelSerializer):
	"""用户优惠券序列化器"""
	coupon = CouponModelSerializer()
	
	class Meta:
		model = UserCoupon
		fields = ["id","start_time","coupon","end_time"]

	