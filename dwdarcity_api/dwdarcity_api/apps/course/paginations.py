
# DRF 分页功能
from rest_framework.pagination import PageNumberPagination

class CoursePageNumberPagination(PageNumberPagination):
    """课程列表分页器"""
    page_query_param = "page" # 地址上面显示的变量名
    page_size = 2  # 每页显示的数据量，默认10条
    # 允许客户端通过指定的参数名来设置每一页数据的大小，默认是size
    page_size_query_param = "size"

    max_page_size = 20 # 限制每一页最大展示的数据量