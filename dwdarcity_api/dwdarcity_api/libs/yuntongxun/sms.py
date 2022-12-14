# -*- coding:utf-8 -*-

from .CCPRestSDK import REST
from django.conf import settings

# 说明：主账号，登陆云通讯网站后，可在"控制台-应用"中看到开发者主账号ACCOUNT SID
_accountSid = settings.SMS["_accountSid"]
# 说明：主账号Token，登陆云通讯网站后，可在控制台-应用中看到开发者主账号AUTH TOKEN
_accountToken = settings.SMS["_accountToken"]
# 请使用管理控制台首页的APPID或自己创建应用的APPID
_appId = settings.SMS["_appId"]
# 说明：请求地址，生产环境配置成app.cloopen.com
# 沙箱环境地址: sandboxapp.cloopen.com
_serverIP = settings.SMS["_serverIP"]

# 说明：请求端口 ，生产环境为8883
_serverPort = settings.SMS["_serverPort"]
# 说明：REST API版本号保持不变
_softVersion = "2013-12-26"


class CCP(object):
    """发送短信的辅助类"""

    def __new__(cls, *args, **kwargs):
        # 判断是否存在类属性_instance，_instance是类CCP的唯一对象，即单例
        if not hasattr(CCP, "_instance"):
            cls._instance = super(CCP, cls).__new__(cls, *args, **kwargs)
            cls._instance.rest = REST(_serverIP, _serverPort, _softVersion)
            cls._instance.rest.setAccount(_accountSid, _accountToken)
            cls._instance.rest.setAppId(_appId)
        return cls._instance

    def send_template_sms(self, to, datas, temp_id):
        """发送模板短信"""
        # @param to 手机号码
        # @param datas 内容数据 格式为数组 例如：{'12','34'}，如不需替换请填 ''
        # @param temp_id 模板Id
        result = self.rest.sendTemplateSMS(to, datas, temp_id)
        # 如果云通讯发送短信成功，返回的字典数据result中statuCode字段的值为"000000"
        return result.get("statusCode") == "000000"


if __name__ == '__main__':
    ccp = CCP()
    # 注意： 测试的短信模板编号为1[以后申请了企业账号以后可以有更多的模板]
    # 参数1: 客户端手机号码,测试时只能发给测试号码
    # 参数2: 短信模块中的数据
    #        短信验证码
    #        短信验证码有效期提示
    # 参数3: 短信模板的id,开发测试时,只能使用1

    # ccp.send_template_sms('15914397060', ['1234',5], 1)
