from rest_framework.views import exception_handler
from django.db import DatabaseError
from redis.exceptions import RedisError

from rest_framework.response import Response
from rest_framework import status
from redis import RedisError

import logging

logger = logging.getLogger('django')


def custom_exception_handler(exc, context):
    """
    自定义异常处理
    :param exc:         本次请求发生的异常信息
    :param context:     本次请求发送异常的执行上下文【本次请求对象request对象，异常发送的时间，行号等...】
    :return:
    """
    response = exception_handler(exc, context)

    if response is None:
        """来到这里有两种情况：要么没有出错，要么出错了而Dajngo或者restframework不识别"""
        view = context['view']
        if isinstance(exc, DatabaseError or isinstance(exc,RedisError)):
            # 数据库异常
            logger.error('[%s] %s' % (view, exc))
            response = Response({'message': '服务器内部错误,请联系客服人员！'}, status=status.HTTP_507_INSUFFICIENT_STORAGE)

    return response

