from django.db import models
from dwdarcity_api.utils.models import BaseModel
from user.models import User
from course.models import Course
from course.models import CourseExpire
from dwdarcity_api.settings import constants
import os


class Order(BaseModel):
    """订单模型"""
    status_choices = (
        (0, '未支付'),
        (1, '已支付'),
        (2, '已取消'),
        (3, '超时取消'),
    )
    pay_choices = (
        (0, '支付宝'),
        (1, '微信支付'),
    )
    order_title = models.CharField(max_length=150, verbose_name="订单标题")
    total_price = models.DecimalField(max_digits=6, decimal_places=2, verbose_name="订单总价", default=0)
    real_price = models.DecimalField(max_digits=6, decimal_places=2, verbose_name="实付金额", default=0)
    order_number = models.CharField(max_length=64, verbose_name="订单号")
    order_status = models.SmallIntegerField(choices=status_choices, default=0, verbose_name="订单状态")
    pay_type = models.SmallIntegerField(choices=pay_choices, default=1, verbose_name="支付方式")
    credit = models.IntegerField(default=0, verbose_name="使用的积分数量")
    coupon = models.IntegerField(null=True, blank=True, default=None, verbose_name="用户优惠券ID")
    order_desc = models.TextField(max_length=500, null=True, blank=True, verbose_name="订单描述")
    pay_time = models.DateTimeField(null=True, verbose_name="支付时间")
    user = models.ForeignKey(User, related_name='user_orders', on_delete=models.DO_NOTHING, verbose_name="下单用户")

    class Meta:
        db_table = "dw_order"
        verbose_name = "订单记录"
        verbose_name_plural = "订单记录"

    def __str__(self):
        return "%s,总价: %s,实付: %s" % (self.order_title, self.total_price, self.real_price)

    @property
    def course_list(self):
        """获取当前订单相关的课程列表"""
        order_course_list = self.order_courses.all()
        data = []
        for detail in order_course_list:
            course = detail.course
            try:
                expire_text = CourseExpire.objects.get(pk=detail.expire).expire_text
            except:
                expire_text = "永久有效"

            data.append({
                "id": course.id,
                "name": course.name,
                "course_img": constants.SERVER_IMAGE_DOMAIN + course.course_img.url,
                "expire_text": expire_text,
                "discount_name": detail.discount_name,
                "price": detail.price,
                "real_price": detail.real_price
            })
        return data


class OrderDetail(BaseModel):
    """
    订单详情
    """
    order = models.ForeignKey(Order, related_name='order_courses', on_delete=models.CASCADE, verbose_name="订单ID")
    course = models.ForeignKey(Course, related_name='course_orders', on_delete=models.CASCADE, verbose_name="课程ID")
    expire = models.IntegerField(default='0', verbose_name="有效期周期", help_text="0表示永久有效")
    price = models.DecimalField(max_digits=6, decimal_places=2, verbose_name="课程原价")
    real_price = models.DecimalField(max_digits=6, decimal_places=2, verbose_name="课程实价")
    discount_name = models.CharField(max_length=120, default="", verbose_name="优惠类型")

    class Meta:
        db_table = "dw_order_detail"
        verbose_name = "订单详情"
        verbose_name_plural = "订单详情"

    def __str__(self):
        return "%s" % (self.course.name)
