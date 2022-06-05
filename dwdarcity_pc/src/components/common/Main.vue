<template>
  <div class="main">
    <div class="study-head">
      <ul class="study-data">
        <li><img src="../../../static/image/study-icon1.svg">
          <div><span>بۇگىن ۇيرەنگەن (ساعات) </span><b>0</b></div>
        </li>
        <li><img src="../../../static/image/study-icon2.svg">
          <div><span>جالپى ۇيرەنگەن(ساعات سانى)</span><b>0</b></div>
        </li>
        <li><img src="../../../static/image/study-icon3.svg">
          <div>
            <span>تاپسىرما(ورتاقءنومىر) </span>
            <b>0</b>
            <div class="button-group"><a href="#" class="button">تاپسىرما ءنومىرىن كورۋ </a></div>
          </div>
        </li>
        <li><img src="../../../static/image/study-icon4.svg">
          <div>
            <span>يە بولعان جارماق </span>
            <b>0</b>
            <div class="button-group"><a href="#" class="button">جارماق ەستەلىگىن كورۋ </a></div>
          </div>
        </li>
      </ul>
      <div class="dashboard">
        <div class="mentor">
          <p class="time">
            <img src="../../../static/image/study-icon5.svg">
            وقىتۋشىدان جەدەل كومەك سۇراۋ!
          </p>
          <span class="tips"> <a>ەگەر ەكى ساعاتقا دەيىن جاۋاپ بولماسا باسقا وقىتۋشى سىزگە حابارلاسادى!</a></span>


          <div class="teacher">
            <img src="../../../static/image/study-head.svg">
            <p class="name">مەنىڭ جەتەكشىم <span class="name2">مالىمەتتەر تابىلمادى...</span></p>
            <p class="service">قىزمەت ۋاقىتى: 09:00 ~ 18:00 </p>
            <button class="button2">
              <img src="../../../static/image/study-icon6.svg">
              كەڭەس سۇرايمىن
            </button>
          </div>

        </div>

      </div>
    </div>
    <ul class="nav">
      <li v-for="nav in nav_list" :key="nav.id" @click="navHander(nav.id)"
          :class="nav.id===tabIndex?'active-link':''">
        {{ nav.name }}
      </li>
    </ul>
    <!--就业班课程-->
    <div class="work" v-if="tabIndex ===1">
      <div>
        <div class="empty-tip">
          <p>
            <span><a href="/employment-course" target="_blank">كاسىپتەنۋ كلاسىندا جىلدام ۇيرنۋگە كەپىلدىكتەر قاراستىرىلعان. </a></span>
            <span><a href="/employment-course" target="_blank">كاسىپتەنۋ كلاسى دەگەن قانداي كلاس؟ </a></span>
          </p>
        </div>
      </div>
    </div>
    <!--专题课程-->
    <div class="my_course" v-if="tabIndex ===2">
      <div>
        <div class="course-content">
          <ul class="tab">
            <li :class="category.id === current_category?'default':''" v-for="category in user_categoryList"
                :key="category.id" @click="categoryChoice(category.id)">
              <p class="name">{{ category.name }}</p><span class="num over">جيىنى 3 ساباق بار</span>
            </li>
          </ul>
          <!--当用户没有选择左边分类时-->
          <div class="right" v-if="current_category === 0">
            <ul class="name"></ul>
            <div class="over-page">
              <div class="not-found"><p>وڭ جاقتان ساباق تۇرلەرىن تاڭداڭىز... </p></div>
            </div>
          </div>

          <!--用户选择左边分类-选择课程时-->
          <div class="right" v-if="current_category > 0">

            <ul class="name">
              <li :class="user_course.course.id === current_course?'this':''" v-for="user_course in user_course_list"
                  :key="user_course.id" v-show="user_course.course.course_category.id === current_category"
                  @click="courseChoice(user_course.course.id)">
                {{ user_course.course.name }}
              </li>
            </ul>
            <div class="over-page" v-if="current_course ===0">
              <div class="not-found"><p>ۇستىنگى جاقتان ساباقتى تاڭداڭىز... </p></div>
            </div>
            <div class="content-box" v-for="user_course in user_course_list" :key="user_course.id">
              <p class="course_name" v-show="current_course === user_course.course.id">
                <!--课程进度-课件下载-->
                <span>{{ user_course.course.name }}<i></i></span>
                <a href="#课件链接" target="_blank" title="点击下载课件">
                  <img src="../../../static/image/down.svg" class="no-hover">
                  <img src="../../../static/image/down-hover.svg"
                       class="hover">ساباق بولشەگىن ءتۇسىرۋ
                </a>
              </p>
              <div class="course-now" v-show="current_course === user_course.course.id">
                <!--课程标题-点击切换显示课时-->
                <div class="course-item">
                  <section class="course-state"><p>وتكەندە ۇيرەنگەن: <span> پروگرامما ءتىلى دەگەن نە؟ </span></p>
                    <p>ۇيرەنىپ بولعان <span>3</span> ساعاتتىق ساباق</p></section>
                  <section class="study-process"><p style="width: 5.17241%;"></p></section>
                </div>
                <button>جالعاستىرۋ</button>
              </div>

              <div v-for="chapter in user_course.course.coursechapters">
                <section class="course-box">
                  <!--课时-->
                  <div class="course-module" v-show="current_course === user_course.course.id">
                    <p class="module-name" @click="chapterChoice(chapter.id)">
                      {{ chapter.name }}
                      <img src="../../../static/image/right-sign.svg"
                           :class="current_chapter===chapter.id?'img-top':'img-left'">
                    </p>

                    <ul class="course-list" v-show="current_chapter === chapter.id">
                      <li v-for="lesson in chapter.coursesections" :key="lesson.id">
                        <button @click="gotoPlay(user_course.course.id,lesson.id)">جالعاستىرۋ</button>
                        <div>
                          <span class="state complete"></span>
                          <p class="class-name">{{ lesson.lesson }}- ساباق {{ lesson.name }}</p>
                        </div>
                        <div>
                          <span class="time">{{ lesson.duration }}</span> <img src="../../../static/image/play3.svg">
                        </div>
                      </li>

                    </ul>
                  </div>

                </section>
              </div>


              <!--              <section class="course-box" v-show="current_course === user_course.course.id">-->
              <!--                &lt;!&ndash;课时&ndash;&gt;-->
              <!--                <div class="course-module">-->
              <!--                  <p class="module-name" @click="course_chapter_isShow=!course_chapter_isShow">-->
              <!--                    {{ user_course.course.name }}-->
              <!--                    <img src="../../../static/image/right-sign.svg" :class="course_chapter_isShow?'img-top':'img-left'">-->
              <!--                  </p>-->

              <!--                  <ul class="course-list" v-show="course_chapter_isShow">-->
              <!--                    <li v-for="lesson in user_course.course.coursechapters" :key="lesson.id">-->
              <!--                      <button @click="gotoPlay(user_course.course.id,lesson.id)">جالعاستىرۋ</button>-->
              <!--                      <div>-->
              <!--                        <span class="state complete"></span>-->
              <!--                        <p class="class-name">{{ lesson.lesson }}- ساباق {{ lesson.name }}</p>-->
              <!--                      </div>-->
              <!--                      <div>-->
              <!--                        <span class="time">{{ lesson.duration }}</span> <img src="../../../static/image/play3.svg">-->
              <!--                      </div>-->
              <!--                    </li>-->

              <!--                  </ul>-->
              <!--                </div>-->

              <!--              </section>-->
            </div>


          </div>
        </div>
      </div>

    </div>
    <!--我的问题-->
    <div class="my-question" v-if="tabIndex ===3">
      <div class="comment-box">
        <div class="all-comment">
          <div class="tips-info">
            <p><img src="../../../static/image/tishi@1x.svg">اڭداتپا: </p>
            <span>1. ەگەر وقىتۋشىءسىزدىڭ ماسەلەڭىزگە جاۋاپ بەرگەن بولسا، وندا وقىتۋشىنىڭ جاۋابىنان باعا بەرۋدى ۇمىتپاڭىز.</span>
            <span>2. ءسىزدىڭ بەرگەن باعاڭىز ءبىز ءۇشىن ماڭىزدى مانگە يە، سوندىقتان ءادىل دە تۋرا باعا بەرگەيسىز.</span>
          </div> <!---->
          <div> <!----></div>
          <div class="empty-tip">
            <p><span>ەشقانداي سۇراق سۇرالماعان... </span></p>
          </div>
        </div>
      </div>
    </div>
    <!--匿名吐槽-->
    <div class="feedback-box" v-if="tabIndex ===4">
      <p class="title">
        سىزگە ساپالى قىزمەت وتەۋ ءۇشىن قۇندى ۇسىنىس - پىكىر قالتىرۋىڭىزدى سۇرايمىز.
      </p>
      <div class="form-group">
        <div class="form-control"><p class="form-title">01 قايسى باعىتتا ۇسىنىس بەرەسىز؟</p>
          <div class="form-content form-content-1">
            <ul>
              <li><span class=""><em></em></span>
                <p>وقىتۋشىنىڭ ساباق ءوتۋى تۋرالى </p></li>
              <li><span class=""><em></em></span>
                <p>سايتتىڭ يقۋاتتارى تۋرالى </p></li>
              <li><span class=""><em></em></span>
                <p>وقىتۋشىنىڭ جاۋاپ بەرۋى تۋرالى </p></li>
              <li><span class=""><em></em></span>
                <p>باسقاشا...</p></li>
            </ul>
          </div>
        </div>
        <div class="form-control"><p class="form-title">02 ۇسىنىس پىكىردى وسىندا جازاسىز </p>
          <div class="form-content form-content-2"><textarea
            placeholder="جازىڭىز"></textarea></div>
        </div>
        <div class="form-control"><p class="form-title">03 قاجەتتى سۋرەت،حۇجاتتار(تاڭداپ تولتىرۋ) </p>
          <div class="form-content form-content-3">
            <div class="dropzone-box">
              <div id="dropzone" class="dropzone dz-clickable">
                <div class="dz-message needsclick">
                  <div>
                    <button type="button" class="dz-button button-primary">حۇجاتتى جۇكتەۋ</button>
                    <br> <span class="note needsclick">حۇجات ۇلكەندىك شەكتەمەسى <strong>5MB</strong></span></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="form-button-group">
        <button class="button">اتسىز تاپسىرۋ</button>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: "Main",
  data() {
    return {
      token: "",
      tabIndex: 2,
      categoryList: [],
      user_categoryList: [],
      current_category: 0,
      current_course: 0,
      current_chapter: 0,
      course_chapter_isShow: false,
      nav_list: [{"id": 1, "name": "كاسىپتەنۋ كلاسى "}, {"id": 2, "name": "بەينە ساباق "}, {
        "id": 3,
        "name": "مەنىڭ سۇراۋلارىم"
      }, {
        "id": 4,
        "name": "اتسىز لەبىز"
      }],
      user_course_list: [],
    }
  },
  mounted(){
    this.token = this.check_user_login();
    this.getCourseCategory();
    this.get_user_course();
  },
  created() {
    this.token = this.check_user_login();
    // this.getCourseCategory();
    // this.get_user_course();
  },
  methods: {
    isShowBtn() {
      console.log('isShowBtn')
    },
    navHander: function (nav_id) {
      this.tabIndex = nav_id;
    },
    check_user_login() {
      // 验证登录
      let token = localStorage.user_token || sessionStorage.user_token
      if (!token) {
        let self = this
        this.$confirm('بۇل يقۋاتتى پايدالانۋ ءۇشىن سايتقا كىرۋىڭىز قاجەت', 'دۋدار ساباقحاناسى', {
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
    getCourseCategory() {
      // 获取分类列表
      this.$axios
        .get(`${this.$settings.HOST}/course/category/`)
        .then((response) => {
          // console.log(response.data)
          this.categoryList = response.data
        })
        .catch((error) => {
          console.log(error.response)
        })
    },
    get_user_course() {
      this.$axios.get(`${this.$settings.HOST}/user/course/`, {
        headers: {
          Authorization: 'jwt ' + this.token,
        },
      }).then(response => {
        // console.log(response.data);
        this.user_course_list = response.data
        this.collect_category();

      }).catch(error => {
        console.log(error.response)
      })
    },
    collect_category() {
      let self = this;
      let arr = [];
      this.user_course_list.forEach(value => {
        // console.log(value.course.course_category)
        arr.push(value.course.course_category.id);
      });
      arr = this.unique(arr)
      // console.log(arr)
      this.categoryList.forEach(item => {
        let that = self
        arr.forEach(ids => {
          if (ids === item.id) {
            that.user_categoryList.push(item);
          }
        })
      })
    },
    categoryChoice(category_id) {
      this.current_category = category_id;
      this.current_course = 0;
    },
    courseChoice(course_id) {
      this.current_course = course_id;
    },
    unique(arr) {
      // 取重
      var result = [];
      for (var i = 0; i < arr.length; i++) {
        if (result.indexOf(arr[i]) < 0) result.push(arr[i]);
      }
      return result
    },
    gotoPlay(course_id, lesson_id) {
      sessionStorage.course_id = course_id;
      sessionStorage.lesson_id = lesson_id;
      this.$router.push({"name": "Play", "params": {course_id: course_id, lesson_id: lesson_id}})
    },
    chapterChoice(chapter_id) {
      if (this.current_chapter === chapter_id) {
        this.current_chapter = 0;
      } else {
        this.current_chapter = chapter_id;
      }

    }
  },
}
</script>

<style scoped>
.main {
  width: 1200px;
  margin: 0 auto;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  flex: 1;
}

.study-head {
  width: 100%;
  height: 255px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 30px;
  margin-bottom: 30px;
}

.study-data {
  width: 650px;
  height: 255px;
  background: #fff;
  box-shadow: 0 4px 8px 0 #e8e8e8;
  border-radius: 3px;
  padding: 32px 40px;
  display: flex;
  flex-wrap: wrap;
  margin-top: 30px;
}

.study-data li {
  width: 50%;
  height: auto;
  display: flex;
  align-items: center;
  margin-bottom: 40px;
}

.study-data li span {
  display: block;
}

.study-data li img {
  width: 38px;
  height: auto;
  margin-right: 25px;
}

.study-data li div span {
  font-size: 14px;
  color: #666;
  margin-bottom: 8px;
  font-family: KazakhSoft Qaniq;
}

.study-data li div b {
  font-weight: 400;
  font-size: 24px;
  color: #4a4a4a;
  font-family: KazakhSoft Qaniq;
}

.study-data li div .button-group {
  display: flex;
}

.study-data li div .button {
  font-size: 14px;
  color: #4a90e2;
  margin-top: 8px;
  font-family: KazakhSoft Qaniq;
  cursor: pointer;
}

.study-head .dashboard {
  margin-top: 30px;
  width: 450px;
  height: 315px;
  background: #fff;
  box-shadow: 0 4px 8px 0 #e8e8e8;
  border-radius: 4px;
  position: relative;
}

.study-head .mentor {
  padding: 15px 10px;
  text-align: center;
  display: block;
}

.study-head .mentor .time {
  font-size: 14px;
  color: #5e5e5e;
  letter-spacing: .23px;
  margin-bottom: 8px;
  font-family: KazakhSoft Qaniq;
  text-align: center;
}

.study-head .mentor .time img {
  width: 24px;
  height: 24px;
  margin-right: 8px;
  display: inline-block;
  border: 0;
  vertical-align: middle;
}

.study-head .mentor .tips {
  display: block;
  height: 30px;
  border-bottom: 1px dashed #e8e8e8;
}

.study-head .mentor .time span {
  color: #fa6240;
  font-family: KazakhSoft Qaniq;
}

.mentor .teacher {
  margin-top: 20px;
}

.mentor .teacher img {
  width: 45px;
  height: 45px;
  margin-bottom: 8px;
  border: 0;
  vertical-align: middle;
  display: inline-block;
}

.mentor .teacher .name {
  font-family: KazakhSoft Qaniq;
  font-size: 14px;
  color: #4a4a4a;
}

.mentor .teacher .name2 {
  color: #fa6240;
}

.mentor .teacher .service {
  font-size: 14px;
  color: #4a4a4a;
  margin-top: 6px;
  margin-bottom: 11px;
  font-family: KazakhSoft Qaniq;
}

.mentor .teacher button {
  width: 132px;
  height: 32px;
  color: #fff;
  font-size: 14px;
  border-radius: 4px;
  background: #4bb6db;
  line-height: 32px;
  font-family: KazakhSoft Qaniq;
}

.mentor .teacher .button2 {
  background: #d0d0d0;
}

.mentor .teacher button img {
  width: 16px;
  height: auto;
  margin-right: 8px;
  margin-top: 4px;
}

.main .nav {
  width: 100%;
  height: 74px;
  display: flex;
  align-items: center;
  background: #fff;
  padding-left: 28px;
  border-bottom: 1px solid rgba(0, 0, 0, .05);
  position: relative;
  margin-top: 40px;
}

.employment {
  width: 100%;
}

.main .nav li {
  height: 74px;
  text-align: center;
  font-family: KazakhSoft Qaniq;
  font-size: 18px;
  color: #000;
  padding: 0 10px;
  line-height: 74px;
  margin-right: 60px;
  cursor: pointer;
}

.main .nav .active-link {
  color: #ffc210;
  border-bottom: 2px solid #ffc210;
  font-family: KazakhSoft Qaniq;
}

.main .empty-tip {
  justify-content: center;
  min-height: 300px;
}

.main .empty-tip, .empty-tip p {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.main .empty-tip p span {
  letter-spacing: 1px;
  font-size: 18px;
  color: #9d9d9d;
  display: block;
  font-family: KazakhSoft Qaniq;
  line-height: 30px;
}

.empty-tip p span a {
  cursor: pointer;
  color: #f5a623;
}

.my_course {
  width: 1200px;
  height: auto;
  margin: 0 auto;
  overflow: hidden;
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.my_course .course-content {
  width: 100%;
  height: auto;
  display: flex;
  margin-top: 30px;
}

.my_course .tab {
  width: 305px;
  height: 694px;
  margin-right: 30px;
  overflow: hidden;
  overflow-y: scroll;
  border-radius: 3px;
  background: #fff;
  margin-bottom: 30px;
  box-shadow: 0 4px 8px 0 #e8e8e8;
}

.my_course .tab .default {
  background: #f6f6f6;
}

.my_course .tab li {
  cursor: pointer;
  border-bottom: 1px solid rgba(0, 0, 0, .05);
  padding: 20px;
  box-sizing: border-box;
  font-family: KazakhSoft Qaniq;
  position: relative;
}

.my_course .tab li .name {
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
  font-size: 18px;
  color: #4a4a4a;
  padding-bottom: 2px;
}

.my_course .over {
  color: #d0d0d0 !important;
}

.my_course .tab li .num {
  font-size: 14px;
}

.my_course .course-content .right {
  flex: 1;
}

.my_course .course-content .right .name {
  background: #fff;
  padding: 20px;
  box-sizing: border-box;
  display: flex;
  align-items: flex-end;
  flex-wrap: wrap;
  margin-bottom: 20px;
}

.my_course .course-content .right .name li {
  cursor: pointer;
  padding: 5px 10px;
  border: 1px solid #dadada;
  border-radius: 4px;
  margin-right: 15px;
  margin-bottom: 18px;
}

.my_course .course-content .right .name .this {
  border: 1px solid #ffc210;
  color: #ffc210;
}

.my_course .over-page {
  flex: 1;
  height: 300px;
  margin-bottom: 30px;
  background: #fff;
  box-shadow: 0 4px 8px 0 #e8e8e8;
  border-radius: 3px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.my_course .over-page .not-found {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.my_course .over-page .not-found p {
  font-size: 18px;
  padding-top: 20px;
  padding-bottom: 5px;
  color: #666;
  text-align: center;
  font-family: KazakhSoft Qaniq;
}

.my_course .content-box {
  flex: 1;
  margin-bottom: 30px;
  background: #fff;
  box-shadow: 0 4px 8px 0 #e8e8e8;
  border-radius: 3px;
}

.my_course .content-box .course_name {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-family: KazakhSoft Qaniq;
  border-bottom: 1px solid #f2f2f2;
  padding: 20px 25px;
}

.my_course .content-box .course_name span {
  font-size: 18px;
  color: #4a4a4a;
}

.my_course .content-box .course_name span i {
  font-size: 14px;
  color: #9d9d9d;
  margin-left: 10px;
  font-style: normal;
}

.my_course .content-box .course_name a {
  font-size: 16px;
  color: #5e5e5e;
  display: flex;
  cursor: pointer;
  align-items: center;
}

.my_course .content-box .course_name a .no-hover {
  width: 17px;
  height: auto;
  margin-right: 8px;
  color: #5e5e5e;
}

.my_course .content-box .course_name a .hover {
  display: none;
}

.my_course .content-box .course-now {
  padding: 20px 25px 30px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.my_course .content-box .course-now .course-item {
  flex: 1;
}

.my_course .content-box .course-now .course-item .course-state {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.course-item .course-state p:first-of-type {
  font-size: 16px;
  color: #9d9d9d;
  font-family: KazakhSoft Qaniq;
}

.course-item .course-state p:first-of-type span {
  color: #666;
}

.my_course .content-box .course-now .course-item .study-process {
  width: 100%;
  height: 10px;
  margin-top: 10px;
  background: #f3f3f3;
  border-radius: 5px;
  position: relative;
}

.my_course .content-box .course-now .course-item .study-process p {
  height: 100%;
  background: #ffc210;
  border-radius: 5px;
  position: absolute;
  right: 0;
  top: 0;
}

.my_course .content-box .course-now button {
  width: 103px;
  height: 36px;
  color: #fff;
  font-size: 16px;
  border-radius: 4px;
  margin-right: 26px;
  background: #ffc210;
  border: 1px solid #ffc210;
  font-family: KazakhSoft Qaniq;
}

.my_course .content-box .course-module {
  margin: 0 25px 12px;
}

.my_course .content-box .course-module .module-name {
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: #4a4a4a;
  font-size: 16px;
  line-height: 18px;
  padding: 16px 20px;
  font-family: KazakhSoft Qaniq;
  background: #f6f6f6;
  box-shadow: 0 0 0 0 #f3f3f3;
  cursor: pointer;
}

.my_course .content-box .course-module .module-name img {
  width: 7px;
  height: auto;
  transition: all .2s ease;
}

.my_course .content-box .course-module ul {
  margin-bottom: -12px;
}

.my_course .content-box .course-module ul li {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 15px 20px;
  position: relative;
  cursor: pointer;
}

.my_course .content-box .course-module ul li:hover {
  background: #fcf7ef;
  box-shadow: 0 0 0 0 #f3f3f3;
}

.my_course .content-box .course-module ul li:hover button {
  opacity: 1;
}

/*鼠标悬浮在列表时显示此按钮*/
.my_course .content-box .course-module ul li button {
  width: 103px;
  height: 36px;
  background: #ffc210;
  border: 1px solid #ffc210;
  border-radius: 4px;
  font-family: KazakhSoft Qaniq;
  font-size: 16px;
  color: #fff;
  position: absolute;
  left: 20px;
  opacity: 0;
}

.my_course .content-box .course-module ul li div {
  display: flex;
  align-items: center;
}

.my_course .content-box .course-module ul li div:first-of-type .complete {
  background: #ffc210;
  border: 1px solid #ffc210;
}

.my_course .content-box .course-module ul li div:first-of-type .state {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-left: 10px;
  border: 1px solid #979797;
}

.my_course .content-box .course-module ul li div:first-of-type .class-name {
  width: 500px;
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
}

.my_course .content-box .course-module ul li .time {
  font-size: 16px;
  color: #666;
  margin-right: 10px;
  font-family: KazakhSoft Qaniq;
}


.my-question {
  width: 1200px;
  height: auto;
}

.my-question .comment-box {
  background: #fff;
  padding-bottom: 50px;
  margin-bottom: 50px;
  box-shadow: 0 2px 4px 0 #e8e8e8;
}

.my-question .all-comment {
  padding-top: 10px;
}

.my-question .all-comment .tips-info {
  width: 1144px;
  margin: 0 auto;
}

.my-question .all-comment .tips-info p {
  font-size: 16px;
  margin: 12px 0;
  padding-bottom: 8px;
  display: flex;
  align-items: center;
  border-bottom: 1px solid rgba(0, 0, 0, .05);
}

.my-question .all-comment .tips-info span {
  display: block;
  line-height: 1.8em;
}

.feedback-box {
  padding: 25px 26px 0;
  background-color: #fff;
  height: auto;
}

.feedback-box .title {
  height: 25px;
  color: #d34a00;
  margin-bottom: 30px;
}

.feedback-box .form-group .form-control .form-title, .feedback-box .title {
  font-size: 18px;
  font-family: ALKATIP Basma Tom, PingFang SC;
  font-weight: 500;
  line-height: 25px;
}

.feedback-box .form-group .form-control .form-content-2 textarea {
  resize: none;
  width: 100%;
  height: 120px;
  opacity: .8;
  border: 1px solid #e8e8e8;
  font-size: 14px;
  font-family: ALKATIP Basma Tom, PingFang SC;
  font-weight: 500;
  color: #9d9d9d;
  padding: 10px;
}

.feedback-box .form-group .form-control .form-title {
  color: #2a2a2a;
}

.feedback-box .form-group .form-control .form-content-3 .dropzone-box {
  margin: 0;
  border: 1px solid #e8e8e8;
  border-radius: 0;
}

.dropzone {
  min-height: 150px;
  background: #fff;
  padding: 54px;
}

.dropzone .dz-message {
  text-align: center;
  margin: 2em 0;
}

.dropzone.dz-clickable .dz-message, .dropzone.dz-clickable .dz-message * {
  cursor: pointer;
}

.dropzone .dz-message .button-primary {
  font-size: 18px;
  font-family: ALKATIP Basma Tom, PingFang SC;
  font-weight: 500;
  color: #4a90e2;
  line-height: 25px;
}

.dropzone .dz-message .note {
  font-size: 14px;
  color: #4a4a4a;
  font-weight: 200;
  display: block;
  margin-top: 16px;
  font-family: KazakhSoft Qaniq;
}

.dropzone .dz-message .note strong {
  color: red;
}

.feedback-box .form-group .form-control .form-content {
  margin: 20px 0 30px;
}

.feedback-box .form-group .form-control .form-content-1 ul li {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.feedback-box .form-group .form-control .form-content-1 ul li span {
  display: flex;
  justify-content: space-around;
  align-items: center;
  border-radius: 100%;
  width: 16px;
  height: 16px;
  border: 1px solid #9d9d9d;
  margin-right: 8px;
}

.feedback-box .form-group .form-control .form-content-1 ul li p {
  font-size: 18px;
  font-family: ALKATIP Basma Tom, PingFang SC;
  font-weight: 400;
  color: #2a2a2a;
  line-height: 25px;
}

.feedback-box .form-button-group {
  display: flex;
  justify-content: center;
  margin-bottom: 30px;
}

.feedback-box .form-button-group .button {
  width: 134px;
  height: 42px;
  background: #f5a623;
  border-radius: 4px;
  font-size: 18px;
  font-family: ALKATIP Basma Tom, PingFang SC;
  font-weight: 500;
  color: #fff;
  line-height: 25px;
  margin-bottom: 30px;
}

.img-top {
  transform: rotate(90deg);
}
</style>
