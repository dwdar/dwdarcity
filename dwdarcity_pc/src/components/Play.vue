<template>
  <div class="video-box">
    <div class="video-right">
      <div class="section-number">
        <div class="back" @click="goBlack">
          <img src="../../static/image/back.svg">قايتۋ
        </div>
        <h1>قويىلىپ جاتقانى: پروگرامما ءتىلى دەگەن نە؟ </h1></div>
      <div class="play-box">
        <div class="wrap-right">
          <videoPlayer class="video-player vjs-custom-skin"
                       ref="videoPlayer"
                       :playsinline="true"
                       :options="playerOptions"
                       @play="onPlayerPlay($event)"
                       @pause="onPlayerPause($event)">
          </videoPlayer>
        </div>
      </div>
    </div>
    <div class="nav-bar"><p class="nav-menu" @click="right=!right">
      <img src="../../static/image/video-right.svg">
    </p>
      <div class="column" v-show="right">
        <div class="top-menu">
          <div class="section-name"><p class="name">پايزون ءتىلى نەگىزدەرى </p>
            <p class="num">
              جالپى 78 ساعات
              <span>／ۇيرەنىپ بولعان 1 ساباق</span></p>
            <div><p class="item">ساباقتىڭ مولشەرى: 18:31:54</p></div>
          </div>
          <div class="switch-list">
            <span :class="tabIndex===1?'active-tab':''" @click="tabIndex=1">ساباق تارۋلارى </span>
            <span :class="tabIndex===2?'active-tab':''" @click="tabIndex=2">سۇراۋلار<a>(295)</a></span>
          </div>
        </div>
        <!--课程章节-->
        <div class="chapter-box" v-show="tabIndex===1">
          <ul>
            <li class="chapter" v-for="chapter in chapter_list" :key="chapter.id">
              <div class="chapter-title">{{ chapter.chapter }}تاراۋ -&nbsp;&nbsp;{{ chapter.name }}</div>
              <ul>
                <li v-for="section in chapter.coursesections" :key="section.id">

                  <div class="section active">
                    <section>
                      <div class="status"><p class="played play"></p></div>
                      <h5 class="section-number">{{ chapter.chapter }}.{{ section.lesson }} {{ section.name }}</h5>
                    </section>
                    <section><span class="section-time">17:50</span>
                      <img src="../../static/image/play2.svg" class="play1">
                      <img src="../../static/image/play2.svg" class="play3">
                    </section>
                  </div>
                </li>

              </ul>
            </li>
          </ul>
        </div>
        <!--讨论提问-->
        <div class="comment-box" v-show="tabIndex===2">
          <div class="box">
            <div class="no-star"><textarea
              placeholder="ۇيرەنۋ تۋرالى پىكىر-كوزقاراسىڭىز، ۇيرەنۋ جاعدايى، ساباق مازمۇنىنا وقىتۋشىنىڭ وقىتۋ مەتودىنا قاتىستى مازمۇندار جازىڭىز"></textarea>
              <div class="bottom">
                <div><p class="normal">تاعى جازۋعا بولاتىنى <span>200</span>ءارىپ
                </p> <!----> <!----></div>
                <button class="">لەبىز قالتىرۋ </button>
              </div>

            </div>
            <div class="comments" style="height: 350px;">
              <dl class="bac">
                <dt><img
                  src="../../static/image/logo.png">
                  <div><p><span class="name">مۇرال </span></p>
                    <p class="time">2022-05-18 00:29:44</p></div>
                </dt>
                <dd>پروگراممادان قاتەلىك شىقتى.</dd>
              </dl>
              <dl class="">
                <dt>
                  <img src="../../static/image/logo@2x.png">

                  <div><p><span class="name">مۇسا </span>
                  </p>
                    <p class="time">2022-05-05 23:33:19</p></div>
                </dt>
                <dd>بۇل ساباق ءوتىلىپ تۇگەدى مە؟</dd>
              </dl>
              <dl class="">
                <dt><img
                  src="../../static/image/avatar2.png">
                  <div><p><span class="name">ايبول17</span>
                  </p>
                    <p class="time">2022-04-28 11:33:34</p></div>
                </dt>
                <dd>ساباق بولشەگى مۇندا: https://pan.baidu.com/s/11dpLSl6muapxMW1mEZpnsg  سيفرى:f5ip</dd>
              </dl>
              <dl class="">
                <dt><img
                  src="../../static/image/logo@2x.png">
                  <div><p><span class="name">ەركىنگۇل </span></p>
                    <p class="time">2022-04-22 14:00:06</p></div>
                </dt>
                <dd>كەسكىن شىقپاي جاتىر </dd>
              </dl>
              <dl class="">
                <dt><img
                  src="../../static/image/logo@2x.png">
                  <div><p><span class="name">ايتۋعان</span>
                  </p>
                    <p class="time">2022-04-13 19:22:30</p></div>
                </dt>
                <dd>پايچارىمنىڭ حانزۋشا نۇسقاسى بار ؟</dd>
              </dl>
              <dl class="">
                <dt><img
                  src="../../static/image/nurlan.png">
                  <div><p><span class="name">نۇرلان ت</span></p>
                    <p class="time">2022-04-12 17:14:36</p></div>
                </dt>
                <dd>كەرمەت ەكەن </dd>
              </dl>
              <dl class="">
                <dt><img
                  src="../../static/image/otan.png">
                  <div><p><span class="name">HJK</span></p>
                    <p class="time">2022-03-24 21:38:03</p></div>
                </dt>
                <dd>111</dd>
              </dl>
              <dl class="">
                <dt><img
                  src="../../static/image/xay.png">
                  <div><p><span class="name">اسىلبەك </span></p>
                    <p class="time">2022-03-21 16:02:18</p></div>
                </dt>
                <dd>ساباق بولشەگىن قايدان الۋعا بولادى؟</dd>
              </dl>
              <dl class="">
                <dt><img
                  src="../../static/image/logo@2x.png">
                  <div><p><span class="name">اسەمبەك مۇعالىم </span>
                  </p>
                    <p class="time">2022-01-03 21:53:16</p></div>
                </dt>
                <dd>ساباق بولشەگىن كوكەك توبىنان الىڭىز</dd>
              </dl>
              <dl class="">
                <dt><img
                  src="../../static/image/halahay.png">
                  <div><p><span class="name">قالاقاي </span>
                  </p>
                    <p class="time">2021-11-15 15:27:29</p></div>
                </dt>
                <dd>ساباق بولشەگىن جولداپ بەرسەڭىز بولاما؟ </dd>
              </dl>
            </div>
            <div class="page">
              <div class="page-list"><span class="jump" style="background-color: rgb(255, 255, 255);">
                <img
                src="../../static/image/halahay.png"></span>
                <span class="jump"
                      style="background-color: rgb(255, 255, 255); display: none;">1</span> <span
                  class="ellipsis"
                  style="background-color: rgb(255, 255, 255); display: none;">
      ...
    </span> <span class="jump bgc">
      1
    </span><span class="jump" style="background-color: rgb(255, 255, 255);">
      2
    </span><span class="jump" style="background-color: rgb(255, 255, 255);">
      3
    </span><span class="jump" style="background-color: rgb(255, 255, 255);">
      4
    </span><span class="jump" style="background-color: rgb(255, 255, 255);">
      5
    </span> <span class="ellipsis" style="background-color: rgb(255, 255, 255); display: none;">
      ...
    </span> <span class="jump" style="background-color: rgb(255, 255, 255); display: none;">
      30
    </span> <span class="jump" style="background-color: rgb(255, 255, 255);"><img
                  src="../../static/image/halahay.png"
                  style="transform: rotate(180deg);"></span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {videoPlayer} from 'vue-video-player'

export default {
  name: 'Play',
  data() {
    return {
      course_id: 0,
      tabIndex: 1, // 当前选项卡显示的下标
      right: true,
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
            // src: 'http://www.dwdarcity.cn:8000/media/video/video.mp4', //你的视频地址（必填）

          },
        ],
        poster: '../static/image/course-cover.jpeg', //视频封面图
        width: document.documentElement.clientWidth, // 默认视频全屏时的最大宽度
        notSupportedMessage: '此视频暂无法播放，请稍后再试', //允许覆盖Video.js无法播放媒体源时显示的默认信息。
      },
      course: {
        teacher: {},
      },
      chapter_list: [],
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
    this.getCourseInfo();
    this.get_course_chapter();
  },
  methods: {
    get_course_id() {
      //   获取课程id
      let course_id = this.$route.params.course_id || sessionStorage.getItem("course_id");
      if (course_id > 0) {
        this.course_id = parseInt(course_id)
      } else {
        let self = this
        this.$alert('对不起，访问页面参数有误！', '错误', {
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
          // console.log(response.data);
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
          console.log(response.data)
          this.chapter_list = response.data
        })
        .catch((error) => {
          this.$message.error('获取课程章节有误...')
        })
    },
    check_user_login() {
      // 验证登录
      let token = localStorage.user_token || sessionStorage.user_token
      if (!token) {
        let self = this;

        this.$confirm('كەسىندى قويۋ ءۇشىن سايتقا كىرۋ قاجەت ', 'دۋدار ساباقحاناسى ', {
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
    onPlayerPlay() {
      // 当视频播放时，执行的方法
      this.right = true;
      // alert('播放视频')
    },
    onPlayerPause() {
      //   当视频暂停时，执行的方法
      this.right = true;
      // alert('关闭视频')
    },
    goBlack() {
      this.$router.go(-1);
    },
  },
  components: {
    videoPlayer,
  },
}
</script>


<style scoped>

.video-box {
  width: 100%;
  height: auto;
  min-height: 100vh;
  display: flex;
  overflow: hidden;
  background: #000;
  position: relative;
}

.video-box .video-right {
  flex: 1;
  position: relative;
}

.video-box .video-right .section-number {
  width: 100%;
  height: 70px;
  margin: 0 auto;
  padding-right: 20px;
  color: #fff;
  background: #333;
  z-index: 2;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}

.video-box .video-right .section-number .back {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 70px;
  height: 24px;
  color: #fff;
  background: #a0a2a8;
  border-radius: 0 2px 2px 0;
  font-size: 14px;
  position: absolute;
  right: 0;
  top: 10px;
  cursor: pointer;
}

.video-box .video-right .section-number .back img {
  width: 8px;
  height: auto;
  margin-left: 8px;
  transform:rotate(180deg);
}

.video-box .video-right .section-number h1 {
  color: #fff;
  font-size: 18px;
  font-weight: 400;
}

.media-player {
  width: 100%;
  height: 100%;
}

.video-box .video-right .wrap-right {
  width: 100%;
  height: 850px;
  margin: 0 auto;
  color: #fff;
  background: #000;
  z-index: 2;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}

.pv-video-player {
  color: #fff;
  font-size: 14px;
  line-height: 1;
  font-family: "helvetica neue", "hiragino sans gb", "tahoma", "microsoft yahei ui", "microsoft yahei", "simsun", "sans-serif";
  position: relative;
  height: 100%;
  margin: 0;
  cursor: default;
  -webkit-font-smoothing: antialiased;
  transition: opacity .5s;
  box-sizing: border-box;
  background: #000;
  text-align: right !important;
  direction: ltr;
}

.pv-video-wrap {
  position: absolute;
  top: 0;
  right: 0;
  left: 0;
  bottom: 0;
}

.pv-video-player * {
  box-sizing: border-box;
}

.pv-log-message {
  font-size: 16px;
  line-height: 20px;
  text-align: center;
  color: #fff;
  position: absolute;
  right: 50%;
  top: 50%;
  padding: 20px;
  z-index: 20;
  background-color: rgba(0, 16, 27, 0.7);
  border-radius: 8px;
  min-width: 250px;
  max-width: 80%;
  opacity: 0;
  transition: opacity 1s;
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  white-space: normal;
  word-break: break-word;
  display: none;
}

.pv-video-player * {
  box-sizing: border-box;
}

.pv-log-error {
  position: absolute;
  width: 100%;
  height: 100%;
  background: #00101b;
  z-index: 30;
  font-size: 16px;
  display: none;
  opacity: 1 !important;
  visibility: visible !important;
}

video.pv-video, .pv-video-cans {
  position: absolute;
  right: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background: #000;
  z-index: auto;
}

.pv-log-error .pv-log-errorIcon {
  position: absolute;
  top: 50%;
  right: 50%;
  margin-right: -23px;
  margin-top: -55px;
  width: 47px;
  height: 31px;
  background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAC8AAAAfCAYAAAB3XZQBAAAByUlEQVRYhe2XPUscURSGHyViECGxsDBaWym4ESyClaVYB/KBqWz9A2lT5C+kzF+wSLBSbNQUYpekCRhSJMSFQESEoI/FzuJ6M6N3dnZmEPaF08w9595nDufcD9RRdUPdU+dUAptTdxOf0ZTxXlouFtSnXulYbXQ4N5JvbT0rGT4XC+qU2kwJCp2biW+Z8LlY2kGPU4JC584slGnRLDcF1QGeiyUMepUSsFoxeDRLp3Mj42/DxqnColiynJumN04d4Jks+H+Ht+sqrXGq3m1uZMHre2vYnGEWqtznb2XBq1Nt3+xTbd9qT9golgGVu6rBugGKqA9fl/rwdakPX5f68HXpTsPfKxg/CMwCT4AZYBqYAMaBYeAB8A84AZrAN+ALsAtsAb8Krd7lBWpBfef1t2Venatb6kt1qBuOvAGz6scCwFn6buvZN1AW/Lp6VgJ4p7bVyVim2CvxG+B1xtgFcJjU8SHwFfgB/EnsPjAGPAQe0eqNRWAp+R7qN7ACfOpFzT/PyNKOuqaOx2YqsCF12dbD4iKY+6+tp1/hsjkIJv6gzncJnGXz6mawzttewL9PJvucZKqX0KG9UH+qRzEJiq35EeA0xrFKXQKoplpFM3MPLwAAAABJRU5ErkJggg==) no-repeat;
}

.pv-log-error .pv-log-errormsg {
  position: absolute;
  top: 50%;
  right: 0;
  width: 100%;
  padding-top: 25px;
  text-align: center;
}

video.pv-video, .pv-video-cans {
  position: absolute;
  right: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background: #000;
  z-index: auto;
}

.pv-loading {
  position: absolute;
  width: 100%;
  text-align: center;
  top: 50%;
  margin-top: -6px;
  display: none;
  opacity: 1;
  transition: opacity .5s;
}

.pv-loading > span:nth-child(1) {
  animation: pvscale 0.75s -0.24s infinite cubic-bezier(0.2, 0.68, 0.18, 1.08);
}

.pv-loading > span {
  width: 12px;
  height: 12px;
  background-color: #fff;
  border-radius: 100%;
  margin: 2px;
  display: inline-block;
}

.pv-cover {
  position: absolute;
  right: 0;
  left: 0;
  top: 0;
  bottom: 0;
  color: #fff;
  z-index: 1;
  display: none;
  background-color: #000;
  background-repeat: no-repeat;
  background-position: center;
  background-repeat: no-repeat;
}

.pv-video-bottom {
  position: absolute;
  right: 0;
  left: 0;
  bottom: 0;
  -ms-user-select: none;
  user-select: none;
  z-index: 1;
}

.pv-cover {
  position: absolute;
  right: 0;
  left: 0;
  top: 0;
  bottom: 0;
  color: #fff;
  z-index: 1;
  display: none;
  background-color: #000;
  background-repeat: no-repeat;
  background-position: center;
  background-repeat: no-repeat;
}

#vjs_video_3 {
  height: 100%;
}

.video-player {
  width: 100%;
  height: 100%;
}

.pv-cover > div {
  position: absolute;
  width: 100%;
  height: 100%;
  right: 0;
  top: 0;
  background-color: #00101b;
  opacity: .7;
  pointer-events: none;
}

.pv-cover > span {
  font-size: 28px;
  width: 60px;
  height: 60px;
  line-height: 60px;
  text-align: center;
  position: absolute;
  right: 50%;
  top: 50%;
  margin-right: -30px;
  margin-top: -30px;
  cursor: pointer;
  z-index: 1;
}

.pv-skin_blue-player.pv-paused .pv-skin-blue.pv-video-bottom {
  height: 63px;
  overflow: visible !important;
}

.pv-skin-blue .pv-progress-wrap {
  position: absolute;
  height: 6px;
  bottom: 100%;
  margin-bottom: -16px;
  cursor: pointer;
  z-index: 2;
  transition: transform .1s;
}

.pv-progress-touch-time {
  display: none;
  padding: 3px;
  font-size: 12px;
  background-color: rgba(0, 16, 27, 0.7);
  position: absolute;
  bottom: 100%;
  margin-bottom: 8px;
  color: #fff;
  border-radius: 4px;
  text-align: center;
}

.pv-thumbnail {
  display: none;
  width: 160px;
  height: 90px;
  margin-bottom: 2px;
}

.pv-currenttime {
  min-width: 44px;
  margin: 0 auto;
  line-height: 16px;
  max-width: 160px;
  word-break: break-all;
  color: #fff;
}

.pv-progress-touch {
  background-color: transparent;
  position: absolute;
  bottom: -2px;
  width: 100%;
  height: 18px;
  cursor: pointer;
  z-index: 5;
}

.pv-skin-blue .pv-progress-bg {
  top: -1px;
  right: 0;
  -ms-transform: scaleY(0.56);
  transform: scaleY(0.56);
  background-color: rgba(255, 255, 255, 0.35);
}

.pv-progress-buffer {
  position: absolute;
  top: 0;
  right: 0;
  right: 0;
  left: 0;
  height: 100%;
  -ms-transform-origin: 0 0;
  transform-origin: 0 0;
}

.pv-progress-current {
  position: absolute;
  top: 0;
  right: 0;
  width: 100%;
  height: 100%;
  font-size: 0;
  z-index: 1;
}

.pv-progress-current-bg {
  position: relative;
  display: inline-block;
  height: 100%;
}

.pv-progress-target {
  position: absolute;
  width: 10px;
  height: 10px;
  top: 50%;
  margin-top: -5px;
  margin-right: -5px;
  border-radius: 5px;
  background-color: #fff;
  opacity: 0;
}

.pv-progress-wrap .pv-progress-key {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  right: 0;
  z-index: 1;
}

.pv-skin-blue .pv-progress-wrap {
  position: absolute;
  height: 6px;
  bottom: 100%;
  margin-bottom: -16px;
  cursor: pointer;
  z-index: 2;
  transition: transform .1s;
}

.pv-progress-wrap .pv-progress-key {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  right: 0;
  z-index: 1;
}

.pv-controls {
  box-sizing: border-box;
  font-family: "helvetica neue", "hiragino sans gb", "tahoma", "microsoft yahei ui", "microsoft yahei", "simsun", "sans-serif";
  font-size: 14px;
}

.pv-skin-blue .pv-controls .pv-controls-right {
  font-size: 12px;
  position: absolute;
  right: 10px;
  top: 0;
  height: 48px;
}

.pv-controls button {
  outline: none;
  border: 0;
  vertical-align: top;
  background-color: transparent;
  text-align: center;
  color: #fff;
  width: 34px;
  cursor: pointer;
  display: inline-block;
  height: 100%;
  font-size: 14px;
  font-family: "helvetica neue", "hiragino sans gb", "tahoma", "microsoft yahei ui", "microsoft yahei", "simsun", "sans-serif";
}

.pv-skin-blue .pv-controls .pv-controls-right > * {
  display: inline-block;
  height: 100%;
  vertical-align: top;
  position: relative;
}

.pv-controls * {
  box-sizing: border-box;
}

.pv-skin-blue .pv-controls .pv-controls-left {
  position: absolute;
  left: 10px;
  top: 0;
  height: 48px;
}

.pv-skin-blue .pv-controls .pv-controls-left > * {
  display: inline-block;
  height: 100%;
  vertical-align: top;
  position: relative;
}

.pv-dm-wrap > button {
  display: none;
  font-size: 15px;
  padding-right: 7px;
  padding-left: 7px;
  width: 28px;
}

.pv-danmu-tip {
  margin-bottom: 11px;
  font-size: 12px;
  line-height: 30px;
  padding: 0 9px;
  border-radius: 4px;
  text-align: center;
  white-space: nowrap;
}

.pv-control-wrap-style {
  z-index: -1;
  opacity: 0;
}

.pv-controls button {
  outline: none;
  border: 0;
  vertical-align: top;
  background-color: transparent;
  text-align: center;
  color: #fff;
  width: 34px;
  cursor: pointer;
  display: inline-block;
  height: 100%;
  font-size: 14px;
  font-family: "helvetica neue", "hiragino sans gb", "tahoma", "microsoft yahei ui", "microsoft yahei", "simsun", "sans-serif";
}

.pv-control-wrap-style, .pv-control-wrap-style2 {
  display: none;
  position: absolute;
  bottom: 100%;
  right: 50%;
  margin-bottom: -4px;
  padding-bottom: 15px;
  -ms-transform: translateX(-50%);
  transform: translateX(-50%);
  transition: opacity .5s;
}

.pv-skin-blue .pv-volume-slider {
  position: relative;
  padding: 9px 13px;
  cursor: pointer;
  border-radius: 4px;
}

.pv-skin-blue .pv-volume-touch {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  right: 0;
  z-index: 10;
  background-color: transparent;
}

.pv-skin-blue .pv-volume-rail {
  height: 100px;
  width: 6px;
  border-radius: 3px;
  background-color: rgba(255, 255, 255, 0.35);
  position: relative;
}

.pv-skin-blue .pv-volume-current {
  position: absolute;
  right: 0;
  bottom: 0;
  width: 100%;
  height: 0%;
  border-radius: 3px;
}

.pv-skin-blue .pv-volume-target {
  width: 12px;
  height: 12px;
  border-radius: 6px;
  background-color: #fff;
  position: absolute;
  top: -6px;
  right: -3px;
}

.pv-skin-blue .pv-controls .pv-btn-radius {
  height: 36px !important;
  padding-top: 12px;
}

.pv-controls button {
  outline: none;
  border: 0;
  vertical-align: top;
  background-color: transparent;
  text-align: center;
  color: #fff;
  width: 34px;
  cursor: pointer;
  display: inline-block;
  height: 100%;
  font-size: 14px;
  font-family: "helvetica neue", "hiragino sans gb", "tahoma", "microsoft yahei ui", "microsoft yahei", "simsun", "sans-serif";
}

.pv-skin-blue .pv-controls .pv-btn-radius button {
  padding: 0;
  font-size: 12px;
  color: #fff !important;
  white-space: nowrap;
  width: auto;
}

.pv-skin-blue .pv-controls .pv-btn-radius button > span {
  min-width: 60px;
  padding: 0 10px;
  line-height: 24px;
  display: inline-block;
  background-color: rgba(0, 0, 0, 0.35);
  border-radius: 12px;
}

.pv-control-wrap-style, .pv-control-wrap-style2 {
  display: none;
  position: absolute;
  bottom: 100%;
  right: 50%;
  margin-bottom: -4px;
  padding-bottom: 15px;
  -ms-transform: translateX(-50%);
  transform: translateX(-50%);
  transition: opacity .5s;
}

.pv-skin-blue .pv-quality-select {
  position: relative;
  width: 64px;
  font-size: 12px;
  line-height: 14px;
  text-align: center;
}

.pv-skin-blue .pv-quality-select > div {
  padding: 8px 0;
  margin-bottom: 1px;
  cursor: pointer;
  text-align: center;
}

.pv-skin-blue .pv-controls .pv-btn-radius {
  height: 36px !important;
  padding-top: 12px;
}

.pv-skin-blue .pv-controls .pv-btn-radius button {
  padding: 0;
  font-size: 12px;
  color: #fff !important;
  white-space: nowrap;
  width: auto;
}

.pv-skin-blue .pv-controls .pv-btn-radius button > span {
  min-width: 60px;
  padding: 0 10px;
  line-height: 24px;
  display: inline-block;
  background-color: rgba(0, 0, 0, 0.35);
  border-radius: 12px;
}

.pv-control-wrap-style, .pv-control-wrap-style2 {
  display: none;
  position: absolute;
  bottom: 100%;
  right: 50%;
  margin-bottom: -4px;
  padding-bottom: 15px;
  -ms-transform: translateX(-50%);
  transform: translateX(-50%);
  transition: opacity .5s;
}

.pv-skin-blue .pv-rate-select {
  position: relative;
  width: 64px;
  font-size: 12px;
  line-height: 14px;
  text-align: center;
}

.pv-skin-blue .pv-rate-select > div {
  padding: 6px 0;
  margin-bottom: 1px;
  cursor: pointer;
  text-align: center;
}

.pv-skin-blue .pv-controls .pv-controls-left > * {
  display: inline-block;
  height: 100%;
  vertical-align: top;
  position: relative;
}

.pv-controls button {
  outline: none;
  border: 0;
  vertical-align: top;
  background-color: transparent;
  text-align: center;
  color: #fff;
  width: 34px;
  cursor: pointer;
  display: inline-block;
  height: 100%;
  font-size: 14px;
  font-family: "helvetica neue", "hiragino sans gb", "tahoma", "microsoft yahei ui", "microsoft yahei", "simsun", "sans-serif";
}

.pv-skin-blue .pv-setting-select-wrap {
  min-width: 168px;
  left: -30px;
  right: auto !important;
  -ms-transform: translateX(0) !important;
  transform: translateX(0) !important;
}

.pv-control-wrap-style {
  z-index: -1;
  opacity: 0;
}

.pv-skin-blue .pv-setting-select {
  font-size: 12px;
  position: relative;
}

.pv-skin-blue .pv-setting-select > div:first-child {
  border-top-left-radius: 4px;
  border-top-right-radius: 4px;
}

.pv-skin-blue .pv-setting-select .pv-setting-tip {
  color: #8f8f8f;
  margin-bottom: 6px;
}

.pv-skin-blue .pv-setting-select > div:last-child {
  border-bottom-left-radius: 4px;
  border-bottom-right-radius: 4px;
}

.pv-skin-blue.pv-subtitle-hide .pv-stream-select-wrap {
  border-top-left-radius: 4px;
  border-top-right-radius: 4px;
}

.pv-skin-blue.pv-stream-hide .pv-stream-select-wrap {
  display: none !important;
}

.pv-skin-blue .pv-setting-select > div {
  padding: 8px;
  margin-bottom: 1px;
}

.pv-skin-blue .pv-setting-select .pv-setting-tip {
  color: #8f8f8f;
  margin-bottom: 6px;
}

.pv-setting-choose {
  white-space: nowrap;
}

.pv-skin-blue .pv-setting-select .pv-setting-choose > span {
  display: inline-block;
  margin-left: 15px;
  cursor: pointer;
}

.pv-fullscreen-page-wrap, .pv-pip-wrap {
  display: none !important;
}

.pv-controls button {
  outline: none;
  border: 0;
  vertical-align: top;
  background-color: transparent;
  text-align: center;
  color: #fff;
  width: 34px;
  cursor: pointer;
  display: inline-block;
  height: 100%;
  font-size: 14px;
  font-family: "helvetica neue", "hiragino sans gb", "tahoma", "microsoft yahei ui", "microsoft yahei", "simsun", "sans-serif";
}

.pv-fullscreen-tip, .pv-fullscreen-page-tip, .pv-pip-tip {
  margin-bottom: 11px;
  font-size: 12px;
  line-height: 30px;
  padding: 0 9px;
  border-radius: 4px;
  text-align: center;
  white-space: nowrap;
}

.pv-skin-blue .pv-controls .pv-controls-left > * {
  display: inline-block;
  height: 100%;
  vertical-align: top;
  position: relative;
}

.pv-controls button {
  outline: none;
  border: 0;
  vertical-align: top;
  background-color: transparent;
  text-align: center;
  color: #fff;
  width: 34px;
  cursor: pointer;
  display: inline-block;
  height: 100%;
  font-size: 14px;
  font-family: "helvetica neue", "hiragino sans gb", "tahoma", "microsoft yahei ui", "microsoft yahei", "simsun", "sans-serif";
}

.pv-fullscreen-tip, .pv-fullscreen-page-tip, .pv-pip-tip {
  margin-bottom: 11px;
  font-size: 12px;
  line-height: 30px;
  padding: 0 9px;
  border-radius: 4px;
  text-align: center;
  white-space: nowrap;
}

.pv-skin-blue .pv-controls .pv-controls-left > * {
  display: inline-block;
  height: 100%;
  vertical-align: top;
  position: relative;
}

.pv-controls button {
  outline: none;
  border: 0;
  vertical-align: top;
  background-color: transparent;
  text-align: center;
  color: #fff;
  width: 34px;
  cursor: pointer;
  display: inline-block;
  height: 100%;
  font-size: 14px;
  font-family: "helvetica neue", "hiragino sans gb", "tahoma", "microsoft yahei ui", "microsoft yahei", "simsun", "sans-serif";
}

.pv-fullscreen-tip, .pv-fullscreen-page-tip, .pv-pip-tip {
  margin-bottom: 11px;
  font-size: 12px;
  line-height: 30px;
  padding: 0 9px;
  border-radius: 4px;
  text-align: center;
  white-space: nowrap;
}

.pv-fullscreen-tip, .pv-fullscreen-page-tip, .pv-pip-tip {
  margin-bottom: 11px;
  font-size: 12px;
  line-height: 30px;
  padding: 0 9px;
  border-radius: 4px;
  text-align: center;
  white-space: nowrap;
}

.pv-menu {
  background-color: rgba(41, 49, 61, 0.9);
  width: 285px;
  border-radius: 6px;
  color: #fff;
  font-size: 12px;
  position: fixed;
  display: none;
  z-index: 31;
  -ms-user-select: none;
  user-select: none;
}

.pv-menu > div {
  line-height: 34px;
  padding: 0 20px;
  color: #fff;
}

.pv-menu > ul {
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  margin: 0;
  padding: 4px 0;
  list-style: none;
}

.pv-menu > ul > li {
  list-style: none;
  color: #fff;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  text-decoration: none;
  padding: 3px 20px;
  line-height: 17px;
}

.video-box .nav-bar {
  align-items: center;
  position: relative;
  z-index: 10;
  height: 920px;
  background-color: red;
}

.video-box .nav-bar .nav-menu {
  position: absolute;
  right: -29px;
  top: 10px;
  z-index: 10;
  width: 28px;
  height: 21px;
  cursor: pointer;
}
.video-box .nav-bar .nav-menu img{
  transform:rotateY(180deg);
}

.video-box .nav-bar .column {
  width: 359px;
  height: 100%;
  z-index: 10;
  background: #282828;
  -webkit-animation: articlemove-data-v-83c417b2 .12s ease;
  animation: articlemove-data-v-83c417b2 .12s ease;
  display: flex;
  flex-direction: column;
}

.video-box .nav-bar .column .section-name {
  width: 100%;
  padding: 30px 18px 18px;
}

.video-box .nav-bar .column .section-name .name {
  width: 100%;
  font-size: 18px;
  color: #fff;
}

.video-box .nav-bar .column .section-name .num {
  width: 100%;
  font-size: 14px;
  color: #9d9d9d;
  margin-top: 3px;
}

.video-box .nav-bar .column .section-name div {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 10px;
}

.video-box .nav-bar .column .section-name div .item {
  width: 180px;
  font-size: 14px;
  color: #d0d0d0;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}

.video-box .nav-bar .column .switch-list {
  width: 100%;
  height: 48px;
  line-height: 48px;
  display: flex;
  align-items: center;
  justify-content: space-around;
  background: #333;
}

.video-box .nav-bar .column .switch-list .active-tab {
  color: #e9e9e9;
  font-size: 16px;
  border-bottom: 2px solid #f5a623;
  z-index: 5;
}

.video-box .nav-bar .column .switch-list span {
  cursor: pointer;
  display: flex;
  align-items: center;
  font-size: 16px;
  color: #d0d0d0;
  position: relative;
}

.video-box .nav-bar .column .switch-list a {
  position: absolute;
  right: 70px;
  top: -1px;
  color: #d0d0d0;
}

.video-box .nav-bar .column .chapter-box {
  overflow-x: hidden;
  overflow-y: scroll;
  box-sizing: border-box;
}

.video-box .nav-bar .column .chapter-box .chapter {
  list-style: none;
  height: auto;
  position: relative;
}

.video-box .nav-bar .column .chapter-box .chapter-title {
  height: 50px;
  line-height: 50px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  padding: 0 18px;
  position: relative;
  font-size: 14px;
  color: #e9e9e9;
  letter-spacing: .23px;
}

.video-box .nav-bar .column .chapter-box .active, .video-box .nav-bar .column .chapter-box .section:hover {
  color: #fff !important;
  background: #333;
}

.video-box .nav-bar .column .chapter-box .section {
  width: 100%;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  color: #9b9b9b;
  position: relative;
  cursor: pointer;
  padding: 0 18px;
}

.video-box .nav-bar .column .chapter-box .section section {
  display: flex;
  align-items: center;
}

.video-box .nav-bar .column .chapter-box .section .status {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: 1px solid #525456;
  margin-right: 5px;
  line-height: 12px;
  display: flex;
  align-items: center;
  justify-content: space-around;
}

.video-box .nav-bar .column .chapter-box .section .status .play {
  width: 7px;
  height: 4px;
  background: #f5a623;
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
  transform: scale(.8);
  transform: rotate(-90deg);
  margin-right: -3px;
}

.video-box .nav-bar .column .chapter-box .section .status .played {
  width: 8px;
  height: 8px;
  background: #f5a623;
  border-radius: 50%;
  transform: scale(.8);
}

.video-box .nav-bar .column .chapter-box .section .section-number {
  width: 200px;
  height: 36px;
  line-height: 36px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  margin-right: 8px;
  margin-left: 30px;
  font-size: 12px;
  letter-spacing: .19px;
}

.video-box .nav-bar .column .chapter-box .section section {
  display: flex;
  align-items: center;
}

.video-box .nav-bar .column .chapter-box .section .section-time {
  width: 36px;
  font-size: 12px;
  letter-spacing: .23px;
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
}

.video-box .nav-bar .column .chapter-box .section img {
  width: 10px;
  height: 10px;
  margin-right: 9px;
}

.video-box .nav-bar .column .chapter-box .section .status {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: 1px solid #525456;
  margin-right: 5px;
  line-height: 12px;
  display: flex;
  align-items: center;
  justify-content: space-around;
}

.video-box .nav-bar .column .chapter-box .section .section-number {
  width: 200px;
  height: 36px;
  line-height: 36px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  margin-right: 8px;
  margin-left: 30px;
  font-size: 12px;
  letter-spacing: .19px;
}

.video-box .nav-bar .column .chapter-box .section .section-time {
  width: 36px;
  font-size: 12px;
  letter-spacing: .23px;
  white-space: nowrap;
  text-overflow: ellipsis;
  overflow: hidden;
}

.video-box .nav-bar .column .chapter-box .section img {
  width: 10px;
  height: 10px;
  margin-right: 9px;
}

.video-box .nav-bar .column .chapter-box .section img {
  width: 10px;
  height: 10px;
  margin-right: 9px;
}

.video-box .nav-bar .column .chapter-box .section .status {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: 1px solid #525456;
  margin-right: 5px;
  line-height: 12px;
  display: flex;
  align-items: center;
  justify-content: space-around;
}

.video-box .nav-bar .column {
  width: 359px;
  height: 100%;
  z-index: 10;
  background: #282828;
  -webkit-animation: articlemove-data-v-83c417b2 .12s ease;
  animation: articlemove-data-v-83c417b2 .12s ease;
  display: flex;
  flex-direction: column;
}

.video-box .nav-bar .column .comment-box {
  flex: 1;
}

.video-box .nav-bar .column .comment-box .box {
  width: 100%;
  height: 100%;
  color: #fff;
  display: flex;
  flex-direction: column;
}

.video-box .nav-bar .column .comment-box .box .no-star {
  padding: 15px 18px;
  box-sizing: border-box;
}

.video-box .nav-bar .column .comment-box .box .no-star textarea {
  width: 100%;
  height: 80px;
  border-radius: 2px;
  font-size: 12px;
  color: #4a4a4a;
  letter-spacing: 0;
  line-height: 18px;
  font-family: PingFangSC-Regular;
  padding: 10px;
  resize: none;
}

.video-box .nav-bar .column .comment-box .box .no-star .bottom {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 8px;
}

.video-box .nav-bar .column .comment-box .box .no-star .bottom div .normal {
  font-size: 12px;
  color: #d0d0d0;
  font-family: PingFangSC-Regular;
}

.video-box .nav-bar .column .comment-box .box .no-star .bottom div .normal span {
  color: #f5a623;
}

.video-box .nav-bar .column .comment-box .box .no-star .bottom button {
  width: 80px;
  height: 30px;
  font-size: 12px;
  border-radius: 4px;
  background: #d0d0d0;
  font-family: PingFangSC-Regular;
  transition: all .35s ease-in-out;
}

.video-box .nav-bar .column .comment-box .box .comments {
  overflow: hidden;
  overflow-y: scroll;
  box-sizing: border-box;
}

.video-box .nav-bar .column .comment-box .box .comments dl {
  padding: 15px 18px;
  margin-bottom: 0;
  border-bottom: 1px solid #303030;
  box-sizing: border-box;
}

.video-box .nav-bar .column .comment-box .box .comments .bac {
  -webkit-animation: Bac 2.6s ease;
  animation: Bac 2.6s ease;
}

.video-box .nav-bar .column .comment-box .box .comments dl dt {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.video-box .nav-bar .column .comment-box .box .comments dl dt img {
  width: 38px;
  height: 38px;
  border-radius: 50%;
  margin-left: 10px;
}

.video-box .nav-bar .column .comment-box .box .comments dl dt div {
  flex: 1;
}

.video-box .nav-bar .column .comment-box .box .comments dl dt div p:first-of-type {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 3px;
}

.video-box .nav-bar .column .comment-box .box .comments dl dt .name {
  font-size: 13px;
  color: #f3f3f3;
  font-family: PingFangSC-Medium;
}

.video-box .nav-bar .column .comment-box .box .comments dl dt .time {
  font-size: 12px;
  color: #b8b8b8;
  font-family: PingFangSC-Regular;
}

.video-box .nav-bar .column .comment-box .box .comments dl dd {
  font-family: PingFangSC-Light;
  font-size: 12px;
  color: #d0d0d0;
  line-height: 22px;
  word-break: break-all;
  word-wrap: break-word;
}

.page {
  width: 100%;
  height: auto;
  margin: 20px 0;
  text-align: center;
}

.page .page-list {
  display: flex;
  align-content: center;
  justify-content: center;
}

.page .page-list span {
  display: inline-block;
  width: 32px;
  height: 32px;
  font-size: 14px;
  text-align: center;
  border-radius: 6px;
  color: rgba(0, 0, 0, .75);
  border: 1px solid #d9d9d9;
  box-sizing: border-box;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: 8px;
  cursor: pointer;
}

.page .page-list .ellipsis {
  width: 20px;
  border: none;
  color: #ccc;
  font-size: 20px;
}

.page .page-list .bgc {
  width: 32px;
  height: 32px;
  color: #fff;
  border: none;
  cursor: default;
  border-radius: 6px;
  background: #ffc210;
}

.page .page-list span {
  display: inline-block;
  width: 32px;
  height: 32px;
  font-size: 14px;
  text-align: center;
  border-radius: 6px;
  color: rgba(0, 0, 0, .75);
  border: 1px solid #d9d9d9;
  box-sizing: border-box;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: 8px;
  cursor: pointer;
}


</style>
