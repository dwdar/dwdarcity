from dwdarcity_api.libs.yuntongxun.sms import CCP
from dwdarcity_api.settings import constants
from mycelery.main import app
import logging

# 关联django
log = logging.getLogger('django')


@app.task(name="send_sms")
def send_sms(mobile,sms_code):
    """发送手机短信"""
    ccp = CCP()
    ret = ccp.send_template_sms(mobile, [sms_code, constants.SMS_EXPIRE_TIME // 60], constants.SMS_TEMPLATE_ID)
    if not ret:
        log.error('用户注册短信发送失败！手机号码%s' % mobile)