from mycelery.main import app
from order.models import Order
from dwdarcity_api.settings import constants
from datetime import datetime


@app.task(name="check_order")
def check_order():
    """超时取消过期订单"""
    # 超时时间：当前时间 > (订单生成时间 + 超时时间）
    now_timestamp = datetime.now().timestamp()
    # 订单过期时间
    timeout_number = now_timestamp - constants.ORDER_OUTTIME  # 数字格式的时间
    timeout_datastring = datetime.fromtimestamp(timeout_number)  # 转换为年月日时分秒格式的时间
    order_outtime_list = Order.objects.filter(order_status=0, create_time__lte=timeout_datastring)
    for order in order_outtime_list:
        order.order_status = 3
        order.save()
