# 设置任务队列的url地址
broker_url = "redis://127.0.0.1:6379/14"
# 设置结果队列的url地址
result_backend = "redis://127.0.0.1:6379/15"

from celery.schedules import crontab
from .main import app

app.conf.beat_schedule = {
    'check_order_outtime': {
        # 本次调度的任务
        'task': 'check_order',
        # 定时任务的调度周期
        # 'schedule': crontab(hour=7, minute=30, day_of_week=1),
        'schedule': crontab(),  # 每分钟
        # 'args': (16, 16), # 注意：任务就是一个函数，所以如果有参数则需要传递
    },
}
