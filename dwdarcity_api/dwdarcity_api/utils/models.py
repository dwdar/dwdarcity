from django.db import models


class BaseModel(models.Model):
    """公共模型"""
    is_show = models.BooleanField(default=False, verbose_name='是否显示')
    orders = models.IntegerField(default=1, verbose_name='排序')
    is_delete = models.BooleanField(default=False, verbose_name='是否删除')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name='添加时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name='修改时间')

    class Meta:
        # 当设置当前模型为抽象模型，在Django数据库迁移的时候不要为它创建表
        abstract = True
