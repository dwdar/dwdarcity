import os
import django
from celery import Celery

# 创建celery主程序对象

app = Celery("luffy")

# celery 与 Django结合
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dwdarcity_api.settings.dev')
django.setup()

# 加载配置
app.config_from_object("mycelery.config")

# 注册任务
app.autodiscover_tasks(["mycelery.sms", "mycelery.mail", "mycelery.order"])

# 启动定时器
# celery -A mycelery.main beat # mycelery.main 是celery的主应用文件
# 通过终端启动celery
# celery -A mycelery.main worker --loglevel=info
