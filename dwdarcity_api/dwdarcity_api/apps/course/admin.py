from django.contrib import admin
from . import models

# Register your models here.
admin.site.register(models.CourseCategory)
admin.site.register(models.Course)
admin.site.register(models.Teacher)
admin.site.register(models.CourseChapter)
admin.site.register(models.CourseLesson)
# 价格优惠相关表格
admin.site.register(models.CourseDiscountType)
admin.site.register(models.CourseDiscount)
admin.site.register(models.Activity)
admin.site.register(models.CoursePriceDiscount)
admin.site.register(models.CourseExpire)
