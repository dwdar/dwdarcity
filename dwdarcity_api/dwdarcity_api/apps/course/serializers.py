from rest_framework import serializers
from .models import CourseCategory
from .models import Course
from .models import Teacher
from .models import CourseChapter


class CourseCategoryModelSerializer(serializers.ModelSerializer):
    """课程分类序列化器"""

    class Meta:
        model = CourseCategory
        fields = ["id", "name"]


class TeacherModelSerializer(serializers.ModelSerializer):
    """教师信息序列化器"""

    class Meta:
        model = Teacher
        fields = ['name', 'title', 'signature', 'image', 'brief']


class CourseListModelSerializer(serializers.ModelSerializer):
    """课程列表序列化器"""

    # 序列化器嵌套（通过外键)
    teacher = TeacherModelSerializer()

    class Meta:
        model = Course
        fields = ['id', 'name', 'course_img', 'students', 'lessons', 'pub_lessons', 'price', 'course_img', 'teacher',
                  'lessons_list', 'discount_name', 'real_price']


class CourseRetrieveModelSerializer(serializers.ModelSerializer):
    """课程详情序列化器"""

    # 序列化器嵌套（通过外键)
    teacher = TeacherModelSerializer()

    class Meta:
        model = Course
        fields = ['id', 'name', 'course_img', 'students', 'lessons', 'pub_lessons', 'price',
                  'course_img', 'teacher', 'level_name', 'lessons_list', 'brief_html', 'course_video', 'discount_name',
                  'real_price', 'activity_time']


from .models import CourseLesson


class CourseLessonModelSerializer(serializers.ModelSerializer):
    """课时信息序列化器"""

    class Meta:
        model = CourseLesson
        fields = ['id', 'name', 'lesson', 'free_trail', 'duration', 'section_link']


class CourseChapterListModelSerializer(serializers.ModelSerializer):
    """课程章节序列化器"""
    coursesections = CourseLessonModelSerializer(many=True)

    class Meta:
        model = CourseChapter
        fields = ['id', 'chapter', 'name', 'coursesections']


