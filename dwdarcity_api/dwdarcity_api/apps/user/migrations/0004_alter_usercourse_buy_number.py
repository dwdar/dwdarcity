# Generated by Django 3.2 on 2022-05-03 11:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0003_usercourse'),
    ]

    operations = [
        migrations.AlterField(
            model_name='usercourse',
            name='buy_number',
            field=models.CharField(max_length=128, null=True, verbose_name='账单号支付平台流水号'),
        ),
    ]