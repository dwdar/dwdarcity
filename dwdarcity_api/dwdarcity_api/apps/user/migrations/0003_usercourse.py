# Generated by Django 3.2 on 2022-05-03 11:48

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('course', '0003_auto_20220412_1918'),
        ('user', '0002_auto_20220428_1122'),
    ]

    operations = [
        migrations.CreateModel(
            name='UserCourse',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_show', models.BooleanField(default=False, verbose_name='是否显示')),
                ('orders', models.IntegerField(default=1, verbose_name='排序')),
                ('is_delete', models.BooleanField(default=False, verbose_name='是否删除')),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='添加时间')),
                ('update_time', models.DateTimeField(auto_now=True, verbose_name='修改时间')),
                ('buy_number', models.CharField(max_length=128, null=True, verbose_name='账单号')),
                ('buy_type', models.SmallIntegerField(choices=[(0, '支付宝'), (1, '微信支付'), (2, '免费活动'), (3, '活动赠品'), (4, '系统赠送')], default=0, verbose_name='购买方式')),
                ('pay_time', models.DateTimeField(null=True, verbose_name='购买时间')),
                ('out_time', models.DateTimeField(null=True, verbose_name='过期时间')),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='course_users', to='course.course', verbose_name='课程')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='user_courses', to=settings.AUTH_USER_MODEL, verbose_name='用户')),
            ],
            options={
                'verbose_name': '课程购买记录',
                'verbose_name_plural': '课程购买记录',
                'db_table': 'ly_user_course',
            },
        ),
    ]
