from django.core.mail import send_mail

from mycelery.main import app
from django.conf import settings
import logging

# 关联django
log = logging.getLogger('django')


@app.task(name='send_to_mail')
def send_to_mail(mail, mail_code):
    msg = '验证码：%s' % mail_code
    ret = send_mail(
        subject='Dwdar学城找回密码',
        message=msg,
        from_email=settings.EMAIL_HOST_USER,
        recipient_list=[mail]  # 这里注意替换成自己的目的邮箱，不然就发到我的邮箱来了：）
    )
    if not ret:
        log.error('用户找回密码邮件发送失败！邮箱地址%s' % mail)
