<template>
  <div class="detail">
    <Header/>
    <div class="main">
      <div class="course-info">
        <div class="wrap-right">
          <videoPlayer class="video-player vjs-custom-skin"
                       ref="videoPlayer"
                       :playsinline="true"
                       :options="playerOptions"
                       @play="onPlayerPlay($event)"
                       @pause="onPlayerPause($event)">
          </videoPlayer>
        </div>
        <div class="wrap-left">
          <h3 class="course-name">{{ course.name }}</h3>
          <p class="data">{{ course.students }}ادام ۇيرەنۋدە &nbsp;&nbsp;&nbsp;&nbsp;جالپى {{ course.lessons }}ساعات /
            {{ course.lessons == course.pub_lessons ? 'ءوتىلىپ بولعان' : (`وتىلگەنى${course.pub_lessons}ساعات `) }}
            &nbsp;&nbsp;&nbsp;&nbsp;قيىندىق دارەجەسى: {{ course.level_name }}</p>

          <div class="sale-time" v-if="course.discount_name">
            <p class="sale-type">{{ course.discount_name }}</p>
            <p class="expire">اياقتاۋعا تەك {{ course.activity_time / (24 * 3600)| time_formant }}كۇن
              {{ course.activity_time / 3600 % 24 | time_formant }}ساعات
              {{ course.activity_time / 60 % 60 | time_formant }} مينۋت <span
                class="second">{{ course.activity_time % 60 | time_formant }}</span> سەكۋند قالدى </p>
          </div>
          <p class="course-price" v-if="course.discount_name">
            <span>قيمىل باعاسى </span>
            <span class="discount">¥{{ course.real_price }}</span>
            <span class="original">¥{{ course.price }}</span>
          </p>
          <p class="course-price" v-else>
            <span></span>
            <span class="discount">¥{{ course.price }}</span>
            <!-- <span class="original">¥{{course.price}}</span> -->
          </p>
          <div class="buy">
            <div class="buy-btn">
              <button class="buy-now" @click="buyNow" v-if="course.real_price >=0">ساتىپ الامىن</button>
              <button class="free" @click="buyNow" v-if="course.real_price === 0">تەگىن وقيمىن</button>
            </div>
            <div class="add-cart"
                 @click="addCart"><img src="/static/image/cart-yellow.svg" alt="">سەبەتكە سالامىن
            </div>
          </div>
        </div>
      </div>
      <div class="course-tab">
        <ul class="tab-list">
          <li :class="tabIndex==1?'active':''" @click="tabIndex=1">ساباقتىڭ ناقتى جاعدايى</li>
          <li :class="tabIndex==2?'active':''"
              @click="tabIndex=2">ساباق مازمۇنى <span :class="tabIndex!=2?'free':''">(تەگىن)</span></li>
          <li :class="tabIndex==3?'active':''"
              @click="tabIndex=3">لەبىزدەر(88)
          </li>
          <li :class="tabIndex==4?'active':''"
              @click="tabIndex=4">سۇراۋلار(123)
          </li>
        </ul>
      </div>
      <div class="course-content">
        <div class="course-tab-list">
          <div class="tab-item"
               v-if="tabIndex==1">
            <div v-html="course.brief_html"></div>
          </div>
          <div class="tab-item"
               v-if="tabIndex==2">
            <div class="tab-item-title">
              <p class="chapter">مازمۇنى </p>
              <p class="chapter-length">جالپى {{ chapter_list.length }}تاراۋ {{ course.lessons }}ساعات </p>
            </div>
            <div class="chapter-item" v-for="chapter in chapter_list" :key="chapter.id">

              <p class="chapter-title" @click="choiceChapter(chapter.id)"> {{ chapter.chapter }}-تاراۋ : {{
                  chapter.name
                }}
                <img :class="chapter.id===current_chapter?'open':''" src="../../static/image/right-sign.svg" alt="">
              </p>


              <ul class="lesson-list" v-for="lesson in chapter.coursesections" :key="lesson.id">
                <li class="lesson-item" v-show="chapter.id === current_chapter">
                  <p class="name">
                    <span class="index">{{ lesson.lesson }}-{{ chapter.chapter }}</span> {{ lesson.name }}
                    <span class="free" v-if="lesson.free_trail">تەگىن</span>
                  </p>
                  <p class="time">{{ lesson.duration }} <img src="/static/image/chapter-player.svg"></p>
                  <button class="try" v-if="lesson.free_trail">تەگىن وقۋ</button>
                  <button class="try" v-else>ساتىپ الۋ</button>
                </li>
              </ul>
            </div>
          </div>

          <div class="tab-item"
               v-if="tabIndex==3">
            لەبىزدەر
          </div>
          <div class="tab-item"
               v-if="tabIndex==4">
            سۇراۋلار
          </div>
        </div>
        <div class="course-side">
          <div class="teacher-info">
            <h4 class="side-title"><span>ساباق مۇعالىمى </span></h4>
            <div class="teacher-content">
              <div class="cont1">
                <img :src="course.teacher  &&  course.teacher.image">
                <div class="name">
                  <p class="teacher-name">{{ course.teacher.name }}</p>
                  <p class="teacher-title">ۇستانىمى: {{ course.teacher.signature }}</p>
                  <p class="teacher-title"> سالاۋاتى: {{ course.teacher.title }}</p>
                </div>
              </div>
              <p class="narrative"> {{ course.teacher.brief }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from './common/Header'
import Footer from './common/Footer'
import {videoPlayer} from 'vue-video-player'

export default {
  name: 'Detail',
  data() {
    return {
      course_id: 0,
      tabIndex: 2, // 当前选项卡显示的下标
      playerOptions: {
        playbackRates: [0.7, 1.0, 1.5, 2.0], // 播放速度
        autoplay: false, //如果true,则自动播放
        muted: false, // 默认情况下将会消除任何音频。
        loop: false, // 循环播放
        preload: 'auto', // 建议浏览器在<video>加载元素后是否应该开始下载视频数据。auto浏览器选择最佳行为,立即开始加载视频（如果浏览器支持）
        language: 'zh-CN',
        aspectRatio: '16:9', // 将播放器置于流畅模式，并在计算播放器的动态大小时使用该值。值应该代表一个比例 - 用冒号分隔的两个数字（例如"16:9"或"4:3"）
        fluid: true, // 当true时，Video.js player将拥有流体大小。换句话说，它将按比例缩放以适应其容器。
        sources: [
          {
            // 播放资源和资源格式
            type: 'video/mp4',
            src: 'http://img.ksbbs.com/asset/Mon_1703/05cacb4e02f9d9e.mp4', //你的视频地址（必填）
          },
        ],
        poster: '../static/image/course-cover.jpeg', //视频封面图
        width: document.documentElement.clientWidth, // 默认视频全屏时的最大宽度
        notSupportedMessage: 'كەسكىن قويىلماي جاتىر...', //允许覆盖Video.js无法播放媒体源时显示的默认信息。
      },
      course: {
        teacher: {},
      },
      chapter_list: [],
      current_chapter: 0,
      course_item_isShow: false,
    }
  },
  filters: {
    time_formant(time) {
      time = parseInt(time);
      if (time < 10) {
        time = "0" + time;
      }
      return time;
    }
  },
  created() {
    // 课程ID
    this.get_course_id();
    this.getCourseInfo()
    this.get_course_chapter()
  },
  methods: {
    get_course_id() {
      //   获取课程id
      let course_id = this.$route.params.id
      if (course_id > 0) {
        this.course_id = parseInt(course_id)
      } else {
        let self = this
        this.$alert('پارامەتردەن قاتەلىك تۋىلدى!', 'قاتەلىك ', {
          callback() {
            self.$router.go(-1)
          },
        })
        return false
      }
      return course_id
    },
    getCourseInfo() {
      // 获取课程信息
      this.$axios
        .get(`${this.$settings.HOST}/course/${this.course_id}/`)
        .then((response) => {
          //   console.log(response.data);
          this.course = response.data
          this.playerOptions.sources[0].src = response.data.course_video
          this.playerOptions.poster = response.data.course_img

          // 设置活动进行时，课程优惠的倒计时
          if (this.course.activity_time > 0) {
            let time = setInterval(() => {
              if (this.course.activity_time > 1) {
                this.course.activity_time -= 1;
              } else {
                clearInterval(time);
              }
            }, 1000)
          }


        })
        .catch((error) => {
          this.$message.error(error.response)
        })
    },
    get_course_chapter() {
      // 获取当前课程的章节和课时
      this.$axios
        .get(`${this.$settings.HOST}/course/chapter/`, {
          params: {course: this.course_id},
        })
        .then((response) => {
          this.chapter_list = response.data
        })
        .catch((error) => {
          this.$message.error('ساباق مازمۇنىن الا المادى...')
        })
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
    buyNow(){
      this.addCart();
      this.$router.push('/cart')
    },
    addCart() {
      // 添加到购物车
      // 添加商品到购物车之前需要认证登录
      let token = this.check_user_login()
      this.$axios
        .post(
          `${this.$settings.HOST}/cart/`,
          {
            course_id: this.course_id,
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
        })
        .catch((error) => {
          this.$message({
            message: response.data.message,
            type: 'success',
          });
        })
    },
    onPlayerPlay() {
      // 当视频播放时，执行的方法
      alert('جارناما اشىلادى')
    },
    onPlayerPause() {
      //   当视频暂停时，执行的方法
      alert('جارناما جابىلادى')
    },
    choiceChapter(chapter_id) {
      if (this.current_chapter === chapter_id) {
        this.current_chapter = 0;
      } else {
        this.current_chapter = chapter_id;
      }

    },
  },
  components: {
    Header,
    Footer,
    videoPlayer,
  },
}
</script>

<style scoped>
.main {
  background: #fff;
  padding-top: 30px;
}

.course-info {
  width: 1200px;
  margin: 0 auto;
  overflow: hidden;
}

.wrap-right {
  float: right;
  width: 640px;
  height: 388px;
  background-color: #000;
}

.wrap-left {
  float: right;
  position: relative;
  height: 388px;
}

.course-name {
  font-size: 20px;
  color: #333;
  padding: 10px 23px;
  letter-spacing: 0.45px;
}

.data {
  padding-right: 23px;
  padding-left: 23px;
  padding-bottom: 16px;
  font-size: 14px;
  color: #9b9b9b;
}

.sale-time {
  width: 464px;
  background: #fa6240;
  font-size: 14px;
  color: #4a4a4a;
  padding: 10px 23px;
  overflow: hidden;
}

.sale-type {
  font-size: 16px;
  color: #fff;
  margin-top: 5px;
  letter-spacing: 0.36px;
  float: right;
}

.sale-time .expire {
  font-size: 14px;
  color: #fff;
  float: left;
}

.sale-time .expire .second {
  width: 24px;
  display: inline-block;
  background: #fafafa;
  color: #5e5e5e;
  padding: 6px 0;
  text-align: center;
}

.course-price {
  background: #fff;
  font-size: 14px;
  color: #4a4a4a;
  padding: 5px 23px;
}

.discount {
  font-size: 26px;
  color: #fa6240;
  margin-right: 10px;
  display: inline-block;
  margin-bottom: -5px;
}

.original {
  font-size: 14px;
  color: #9b9b9b;
  margin-right: 10px;
  text-decoration: line-through;
}

.buy {
  width: 464px;
  padding: 0px 23px;
  position: absolute;
  right: 0;
  bottom: 20px;
  overflow: hidden;
}

.buy .buy-btn {
  float: right;
}

.buy-now {
  width: 125px;
  height: 40px;
  border: 0;
  background: #ffc210;
  border-radius: 4px;
  color: #fff;
  cursor: pointer;
  margin-left: 15px;
  outline: none;
  font-family: KazakhSoft Qaniq;
}

.buy .free {
  width: 125px;
  height: 40px;
  border-radius: 4px;
  cursor: pointer;
  margin-left: 15px;
  background: #fff;
  color: #ffc210;
  border: 1px solid #ffc210;
  font-family: KazakhSoft Qaniq;
}

.add-cart {
  float: left;
  font-size: 14px;
  color: #ffc210;
  text-align: center;
  cursor: pointer;
  margin-top: 10px;
}

.add-cart img {
  width: 20px;
  height: 18px;
  margin-left: 7px;
  vertical-align: middle;
}

.course-tab {
  width: 100%;
  background: #fff;
  margin-bottom: 30px;
  box-shadow: 0 2px 4px 0 #f0f0f0;
}

.course-tab .tab-list {
  width: 1200px;
  margin: auto;
  color: #4a4a4a;
  overflow: hidden;
}

.tab-list li {
  float: right;
  margin-left: 15px;
  padding: 26px 20px 16px;
  font-size: 17px;
  cursor: pointer;
}

.tab-list .active {
  color: #ffc210;
  border-bottom: 2px solid #ffc210;
}

.tab-list .free {
  color: #fb7c55;
}

.course-content {
  width: 1200px;
  margin: 0 auto;
  background: #fafafa;
  overflow: hidden;
  padding-bottom: 40px;
}

.course-tab-list {
  width: 880px;
  height: auto;
  padding: 20px;
  background: #fff;
  float: right;
  box-sizing: border-box;
  overflow: hidden;
  position: relative;
  box-shadow: 0 2px 4px 0 #f0f0f0;
}

.tab-item {
  width: 880px;
  background: #fff;
  padding-bottom: 20px;
  box-shadow: 0 2px 4px 0 #f0f0f0;
}

.tab-item-title {
  justify-content: space-between;
  padding: 25px 20px 11px;
  border-radius: 4px;
  margin-bottom: 20px;
  border-bottom: 1px solid #333;
  border-bottom-color: rgba(51, 51, 51, 0.05);
  overflow: hidden;
}

.chapter {
  font-size: 17px;
  color: #4a4a4a;
  float: right;
}

.chapter-length {
  float: left;
  font-size: 14px;
  color: #9b9b9b;
  letter-spacing: 0.19px;
}

.chapter-title {
  font-size: 16px;
  color: #4a4a4a;
  letter-spacing: 0.26px;
  padding: 12px;
  background: #eee;
  border-radius: 2px;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-align: center;
  align-items: center;
  margin-top: 5px;
  justify-content: space-between;
}

.chapter-title img {
  width: 18px;
  height: 18px;
  margin-left: 15px;
  vertical-align: middle;
  transform: rotateY(180deg);
}

.chapter-title .open {
  transform: rotateZ(90deg);
}

.lesson-list {
  padding: 0 20px;
}

.lesson-list .lesson-item {
  padding: 15px 20px 15px 36px;
  cursor: pointer;
  justify-content: space-between;
  position: relative;
  overflow: hidden;
}

.lesson-item .name {
  font-size: 14px;
  color: #666;
  float: right;
}

.lesson-item .index {
  margin-left: 5px;
}

.lesson-item .free {
  font-size: 12px;
  color: #fff;
  letter-spacing: 0.19px;
  background: #ffc210;
  border-radius: 100px;
  padding: 1px 9px;
  margin-right: 10px;
}

.lesson-item .time {
  font-size: 14px;
  color: #666;
  letter-spacing: 0.23px;
  opacity: 1;
  transition: all 0.15s ease-in-out;
  float: left;
}

.lesson-item .time img {
  width: 18px;
  height: 18px;
  margin-right: 15px;
  vertical-align: text-bottom;
}

.lesson-item .try {
  width: 86px;
  height: 28px;
  background: #ffc210;
  border-radius: 4px;
  font-size: 14px;
  color: #fff;
  position: absolute;
  left: 20px;
  top: 10px;
  opacity: 0;
  transition: all 0.2s ease-in-out;
  cursor: pointer;
  outline: none;
  border: none;
}

.lesson-item:hover {
  background: #fcf7ef;
  box-shadow: 0 0 0 0 #f3f3f3;
}

.lesson-item:hover .name {
  color: #333;
}

.lesson-item:hover .try {
  opacity: 1;
  font-family: "ALKATIP Basma Tom";
}

.course-side {
  width: 300px;
  height: auto;
  margin-right: 20px;
  float: left;
}

.teacher-info {
  background: #fff;
  margin-bottom: 20px;
  box-shadow: 0 2px 4px 0 #f0f0f0;
}

.side-title {
  font-weight: normal;
  font-size: 17px;
  color: #4a4a4a;
  padding: 18px 14px;
  border-bottom: 1px solid #333;
  border-bottom-color: rgba(51, 51, 51, 0.05);
}

.side-title span {
  display: inline-block;
  border-right: 2px solid #ffc210;
  padding-right: 12px;
}

.teacher-content {
  padding: 30px 20px;
  box-sizing: border-box;
}

.teacher-content .cont1 {
  margin-bottom: 12px;
  overflow: hidden;
}

.teacher-content .cont1 img {
  width: 54px;
  height: 54px;
  margin-left: 12px;
  float: right;
}

.teacher-content .cont1 .name {
  float: left;
}

.teacher-content .cont1 .teacher-name {
  width: 188px;
  font-size: 16px;
  color: #4a4a4a;
  padding-bottom: 4px;
}

.teacher-content .cont1 .teacher-title {
  width: 188px;
  font-size: 13px;
  color: #9b9b9b;
  white-space: nowrap;
}

.teacher-content .narrative {
  font-size: 14px;
  color: #666;
  line-height: 24px;
}
</style>
