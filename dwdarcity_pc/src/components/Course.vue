<template>
  <div class="course">
    <Header></Header>
    <div class="main">
      <!-- 筛选条件 -->
      <div class="condition">
        <ul class="cate-list">
          <li class="title">تۇرلەر:</li>
          <li @click="category=0" :class="category==0? 'this':''">بارلىق</li>
          <li @click="category=cat.id" :class="category==cat.id?'this':''" v-for="cat in categoryList" :key="cat.id">
            {{ cat.name }}
          </li>
        </ul>

        <div class="ordering">
          <ul>
            <li class="title">ىلعاۋ:</li>
            <li @click="changer_order_type('id')" class="default" :class="changet_order_class('id')">ادەپكى</li>
            <li @click="changer_order_type('students')" class="hot" :class="changet_order_class('students')">ۇنامدىلىق
            </li>
            <li @click="changer_order_type('price')" class="price" :class="changet_order_class('price')">باعاسى</li>
          </ul>
          <p class="condition-result">مۇندا {{ courseList.length }} ساباق تابىلدى</p>
        </div>

      </div>
      <!-- 课程列表 -->
      <div class="course-list">
        <div class="course-item" v-for="course in courseList" :key="course.id">
          <router-link :to="'/course/detail/'+course.id">
            <div class="course-image"><img :src="course.course_img" alt=""></div>
            <div class="course-info">
              <h3>
                <!--              <router-link :to="'/course/detail/'+course.id">{{ course.name }}</router-link>-->
                <a href="#">{{ course.name }}</a>
                <span><img src="/static/image/avatar1.svg" alt="">{{ course.students }}ادام ۇيرەنگەن</span>
              </h3>

              <p class="teather-info">

                وقىتۋشى: {{ course.teacher.name }}<br>
                ۇستانىمى:
                {{ course.teacher.signature }}<br>
                سالاۋاتى:
                {{ course.teacher.title }}
                <span>جالپى {{
                    course.lessons
                  }}ساعات /    {{
                    course.lessons == course.pub_lessons ? 'ءوتىلىپ بولعان' : (`وتىلگەنى ${course.pub_lessons}ساعات`)
                  }}   </span>
              </p>

              <ul class="lesson-list">
                <li v-for="(lesson,key) in course.lessons_list" :key="lesson.id">
                  <span class="lesson-title">{{ key + 1 }} | -{{ lesson.lesson }}ساعات ：{{ lesson.name }}</span>
                  <span class="free" v-if="lesson.free_trail">تەگىن </span>
                </li>

              </ul>
              <div class="pay-box">
                <span class="discount-type" v-show="course.discount_name">{{ course.discount_name }}</span>
                <span class="discount-price">￥{{ course.real_price }}يۋان </span>
                <span class="original-price" v-show="course.discount_name">اۋەلگى باعاسى:{{ course.price }}يۋان </span>
                <span class="buy-now" @click="addCart(course.id)">ساتىپ الامىن </span>
              </div>
            </div>
          </router-link>
        </div>

      </div>
      <!-- 页码 -->
      <el-pagination
        background layout="prev, pager, next"
        :page-size="filters.size"
        :page-sizes="[2,3,5,10]"
        @current-change="handlerCurrentChange"
        :total="total">
      </el-pagination>
    </div>

    <Footer></Footer>
  </div>
</template>

<script>
import Header from './common/Header'
import Footer from './common/Footer'

export default {
  name: 'Course',
  data() {
    return {
      category: 0,
      categoryList: [],
      total: 0, //总数据量
      filters: {
        type: 'id', // 筛选类型，id表示默认，sutdents表示人气，price表示价格
        orders: 'desc', // 排序的类型 【控制样式】，asc 表示升序desc表示将序
        size: 10, // 每页显示数据量
        page: 1,  // 当前页
      },
      courseList: [],
    }
  },
  watch: {
    //   监听器
    category() {
      this.get_course()
    },
  },
  created() {
    this.getCourseCategory()
    this.get_course()
  },
  methods: {
    getCourseCategory() {
      // 获取分类列表
      this.$axios
        .get(`${this.$settings.HOST}/course/category/`)
        .then((response) => {
          //   console.log(response.data)
          this.categoryList = response.data
        })
        .catch((error) => {
          console.log(error.response)
        })
    },
    get_course() {
      //  --------获取课程信息

      //   筛选条件
      let filters = {
        page: this.filters.page,
        size: this.filters.size
      }
      if (this.filters.orders === 'desc') {
        filters.ordering = '-' + this.filters.type;

      } else {
        filters.ordering = this.filters.type;
      }

      // 判断是否要根据分类显示课程信息
      if (this.category > 0) {
        filters.course_category = this.category
      }
      this.$axios
        .get(`${this.$settings.HOST}/course/`, {
          params: filters,
        })
        .then((response) => {
          // console.log(response.data)
          this.courseList = response.data.results;
          this.total = response.data.count;
        })
        .catch((error) => {
          console.log(error.response)
        })
    },
    changer_order_type(type) {
      //  更改升序或降序
      if (this.filters.type === type && this.filters.orders === 'desc') {
        this.filters.orders = 'asc'
      } else if (this.filters.type === type && this.filters.orders === 'asc') {
        this.filters.orders = 'desc'
      }

      //   更改排序方式
      this.filters.type = type
      // 重新获取课程数据
      this.get_course();

    },
    changet_order_class(type) {
      // 更改当前筛选条件的高亮方式
      if (this.filters.type === type && this.filters.orders === 'asc') {
        return 'this asc'
      } else if (this.filters.type === type && this.filters.orders === 'desc') {
        return 'this desc'
      } else {
        return ''
      }
    },
    handlerCurrentChange(page) {
      // element-ue 实现，根据页面从新获取数据
      this.filters.page = page;
      this.get_course();

    },
    handlerSizeChange(size) {
      // 切换单页显示的数据量
      this.filters.size = size;
      // 重置页面
      this.filters.page = 1;
      this.get_course();
    },
    check_user_login() {
      // 验证登录
      let token = localStorage.user_token || sessionStorage.user_token
      if (!token) {
        let self = this;

        this.$confirm('سەبەتتى پايدالانۋ ءۇشىن سايتقا كىرۋ قاجەت!', 'دۋدار ساباقحاناسى ', {
          confirmButtonText: 'راستاۋ',
          cancelButtonText: 'قالتىرۋ',
          type: 'warning',
        }).then(() => {
          self.$router.push('/user/login')
        })
        return false
      }
      return token
    },
    addCart(course_id) {
      // 添加到购物车
      // 添加商品到购物车之前需要认证登录
      let token = this.check_user_login()
      this.$axios
        .post(
          `${this.$settings.HOST}/cart/`,
          {
            course_id: course_id,
          },
          {
            headers: {
              //  提交jwt 的时候，必须向后端声明该token 由jwt 生成的
              Authorization: 'jwt ' + token,
            },
          }
        )
        .then((response) => {
          //   console.log(response.data)
          this.$message({
            message: "مەڭگەرۋ تامامدالدى!",
            duration: 600,
            type: 'success',
          });
          //   购物车s
          this.cart_length = response.data.cart_length;
          // 通过vuex 修改购物车中的商品数量
          this.$store.commit('add_cart', response.data.cart_length)
          this.$router.push('/cart');
        })
        .catch((error) => {
          this.$message({
            message: response.data.message,
            type: 'success',
          });
        })
    },
  },
  components: {
    Header,
    Footer,
  },
}
</script>


<style scoped>
.course {
  background: #f6f6f6;
}

.course .main {
  width: 1100px;
  margin: 35px auto 0;
}

.course .condition {
  margin-bottom: 35px;
  padding: 25px 30px 25px 20px;
  background: #fff;
  border-radius: 4px;
  box-shadow: 0 2px 4px 0 #f0f0f0;
}

.course .cate-list {
  border-bottom: 1px solid #333;
  border-bottom-color: rgba(51, 51, 51, 0.05);
  padding-bottom: 18px;
  margin-bottom: 17px;
}

.course .cate-list::after {
  content: '';
  display: block;
  clear: both;
}

.course .cate-list li {
  float: right;
  font-size: 16px;
  padding: 6px 15px;
  line-height: 16px;
  margin-right: 14px;
  position: relative;
  transition: all 0.3s ease;
  cursor: pointer;
  color: #4a4a4a;
  border: 1px solid transparent; /* transparent 透明 */
}

.course .cate-list .title {
  color: #888;
  margin-right: 0;
  letter-spacing: 0.36px;
  padding: 0;
  line-height: 28px;
}

.course .cate-list .this {
  color: #ffc210;
  border: 1px solid #ffc210 !important;
  border-radius: 30px;
}

.course .ordering::after {
  content: '';
  display: block;
  clear: both;
}

.course .ordering ul {
  float: right;
}

.course .ordering ul::after {
  content: '';
  display: block;
  clear: both;
}

.course .ordering .condition-result {
  float: left;
  font-size: 14px;
  color: #9b9b9b;
  line-height: 28px;
}

.course .ordering ul li {
  float: right;
  padding: 6px 15px;
  line-height: 16px;
  margin-right: 14px;
  position: relative;
  transition: all 0.3s ease;
  cursor: pointer;
  color: #4a4a4a;
}

.course .ordering .title {
  font-size: 16px;
  color: #888;
  letter-spacing: 0.36px;
  margin-right: 0;
  padding: 0;
  line-height: 28px;
}

.course .ordering .this {
  color: #ffc210;
}

.course .ordering .price {
  position: relative;
}

.course .ordering .this::before,
.course .ordering .this::after {
  cursor: pointer;
  content: '';
  display: block;
  width: 0px;
  height: 0px;
  border: 5px solid transparent;
  position: absolute;
  left: 0;
}

.course .ordering .this::before {
  border-bottom: 5px solid #aaa;
  margin-bottom: 2px;
  top: 2px;
}

.course .ordering .this::after {
  border-top: 5px solid #aaa;
  bottom: 2px;
}

.course .ordering .asc::before {
  border-bottom-color: #ffc210;
}

.course .ordering .desc::after {
  border-top-color: #ffc210;
}

.course .course-item:hover {
  box-shadow: 4px 6px 16px rgba(0, 0, 0, 0.5);
}

.course .course-item {
  width: 1050px;
  background: #fff;
  padding: 20px 30px 20px 20px;
  margin-bottom: 35px;
  border-radius: 2px;
  cursor: pointer;
  box-shadow: 2px 3px 16px rgba(0, 0, 0, 0.1);
  /* css3.0 过渡动画 hover 事件操作 */
  transition: all 0.2s ease;
}

.course .course-item::after {
  content: '';
  display: block;
  clear: both;
}

/* 顶级元素 父级元素  当前元素{} */
.course .course-item .course-image {
  float: right;
  width: 423px;
  height: 210px;
  margin-left: 30px;
}

.course .course-item .course-image img {
  width: 100%;
}

.course .course-item .course-info {
  float: right;
  width: 596px;
}

.course-item .course-info h3 {
  font-size: 26px;
  color: #333;
  font-weight: normal;
  margin-bottom: 8px;
}

.course-item .course-info h3 span {
  font-size: 14px;
  color: #9b9b9b;
  float: left;
  margin-top: 14px;
}

.course-item .course-info h3 span img {
  width: 11px;
  height: auto;
  margin-left: 7px;
}

.course-item .course-info .teather-info {
  font-size: 14px;
  color: #9b9b9b;
  margin-bottom: 14px;
  padding-bottom: 14px;
  border-bottom: 1px solid #333;
  border-bottom-color: rgba(51, 51, 51, 0.05);
}

.course-item .course-info .teather-info span {
  float: left;
}

.course-item .lesson-list::after {
  content: '';
  display: block;
  clear: both;
}

.course-item .lesson-list li {
  float: right;
  width: 44%;
  font-size: 14px;
  color: #666;
  padding-right: 22px;
  /* background: url("路径") 是否平铺 x轴位置 y轴位置 */
  background: url('/static/image/play-icon-gray.svg') no-repeat right 4px;
  margin-bottom: 15px;
}

.course-item .lesson-list li .lesson-title {
  /* 以下3句，文本内容过多，会自动隐藏，并显示省略符号 */
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
  display: inline-block;
  max-width: 200px;
}

.course-item .lesson-list li:hover {
  background-image: url('/static/image/play-icon-yellow.svg');
  color: #ffc210;
}

.course-item .lesson-list li .free {
  width: 34px;
  height: 20px;
  color: #fd7b4d;
  vertical-align: super;
  margin-right: 10px;
  border: 1px solid #fd7b4d;
  border-radius: 2px;
  text-align: center;
  font-size: 13px;
  white-space: nowrap;
}

.course-item .lesson-list li:hover .free {
  color: #ffc210;
  border-color: #ffc210;
}

.course-item .pay-box::after {
  content: '';
  display: block;
  clear: both;
}

.course-item .pay-box .discount-type {
  padding: 6px 10px;
  font-size: 16px;
  color: #fff;
  text-align: center;
  margin-left: 8px;
  background: #fa6240;
  border: 1px solid #fa6240;
  border-radius: 10px 0 10px 0;
  float: right;
}

.course-item .pay-box .discount-price {
  font-size: 24px;
  color: #fa6240;
  float: right;
}

.course-item .pay-box .original-price {
  text-decoration: line-through;
  font-size: 14px;
  color: #9b9b9b;
  margin-right: 10px;
  float: right;
  margin-top: 10px;
}

.course-item .pay-box .buy-now {
  width: 120px;
  height: 38px;
  background: transparent;
  color: #fa6240;
  font-size: 16px;
  border: 1px solid #fd7b4d;
  border-radius: 3px;
  transition: all 0.2s ease-in-out;
  float: left;
  text-align: center;
  line-height: 38px;
}

.course-item .pay-box .buy-now:hover {
  color: #fff;
  background: #ffc210;
  border: 1px solid #ffc210;
}

.el-pagination {
  text-align: center;
  margin-bottom: 20px;
}
</style>
