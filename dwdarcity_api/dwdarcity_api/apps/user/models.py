from django.db import models
from django.contrib.auth.models import AbstractUser
from dwdarcity_api.utils.models import BaseModel
from course.models import Course

# Create your models here.
class User(AbstractUser):
    mobile = models.CharField(max_length=15, unique=True, verbose_name='手机号码')
    avatar = models.ImageField(upload_to='avatar', null=True, blank=True, verbose_name='用户头像')
    wxcaht = models.CharField(max_length=64, null=True, blank=True, verbose_name='微信号')
    credit = models.IntegerField(default=0,blank=True,verbose_name='积分')

    class Meta:
        db_table = "dw_user"
        verbose_name = '用户信息'
        verbose_name_plural = verbose_name

class Credit(BaseModel):
    """积分记录"""
    OPERA_OPTION = (
        (1,"攒取"),
        (2,"消费")
    )
    user = models.ForeignKey(to="User",on_delete=models.CASCADE,verbose_name='用户',related_name='user_credit')
    opera = models.SmallIntegerField(choices=OPERA_OPTION,verbose_name="操作类型")
    number = models.SmallIntegerField(default=0,verbose_name="积分数值")

    class Meta:
        db_table = "dw_credit"
        verbose_name = "积分记录"
        verbose_name_plural = "积分记录"

    def __str__(self):
        return "%s %s %s 积分" %(self.user.username,self.OPERA_OPTION[self.opera][1],self.number)


class UserCourse(BaseModel):
    """用户的课程购买记录"""
    pay_choices = (
        (0, '支付宝'),
        (1, '微信支付'),
        (2, '免费活动'),
        (3, '活动赠品'),
        (4, '系统赠送'),
    )
    user = models.ForeignKey(User, related_name='user_courses', on_delete=models.DO_NOTHING,verbose_name="用户")
    course = models.ForeignKey(Course, related_name='course_users', on_delete=models.DO_NOTHING, verbose_name="课程")
    trado_no = models.CharField(max_length=128, null=True, verbose_name="账单号支付平台流水号")
    buy_type = models.SmallIntegerField(choices=pay_choices, default=0, verbose_name="购买方式")
    pay_time = models.DateTimeField(null=True, verbose_name="购买时间")
    out_time = models.DateTimeField(null=True, verbose_name="过期时间")

    class Meta:
        db_table = 'dw_user_course'
        verbose_name = '课程购买记录'
        verbose_name_plural = verbose_name
