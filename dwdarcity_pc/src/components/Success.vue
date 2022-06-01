<template>
  <div class="success">
    <Header :current_page="current_page"/>
    <div class="main">
      <div class="title">
        <div class="success-tips">
          <p class="tips1">بۇل جولى ءسىز  {{ course_list.length }} ساباق ساتىپ الدىڭىز </p>
          <p class="tips2">كوكەك توبىنا قوسىلىپ  <span>993673962</span> پىكرلەسىڭىز</p>
        </div>
      </div>
      <div class="order-info">
        <p class="info1"><b>اقى تولەگەن ۋاقىت: </b><span>{{ pay_time|timeformat }}</span></p>
        <p class="info2"><b>تولەنگەن سوما: </b><span>{{ real_price.toFixed(2) }}</span></p>
        <p class="info3"><b>ساتىپ العان ساباق </b><span>
          <span v-for="course in course_list" :key="course.id">
            《<router-link :to="'/course/detail/'+course.id"> {{ course.name }} </router-link>》</span>
        </span></p>
      </div>
      <div class="wechat-code">
        <p>اڭداتپا: ءۇنحات توبىنا قوسىلىپ ساباقتىڭ جاڭالانۋ جاعدايىنان حاباردار بولىڭىز، ايتپەگەندە ۇيرەنۋگە ىقال جەتەدى.</p>
      </div>
      <div class="study">
        <router-link to="/study"><span>ۇيرەنەمىن </span></router-link>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "./common/Header"
import Footer from "./common/Footer"

export default {
  name: "Success",
  data() {
    return {
      current_page: 0,
      pay_time: "",
      course_list: [],
      real_price: 0,
    };
  },
  created() {
    // 把地址栏上面的支付结果，发给后端处
    this.alipayresultHandler();
  },
  filters: {
    timeformat(value) {
      let datetime = new Date(value);
      let y = datetime.getFullYear();
      let m = datetime.getMonth() + 1;
      let d = datetime.getDay();
      let H = datetime.getHours();
      let M = datetime.getMinutes();
      let S = datetime.getSeconds();
      m = m < 10 ? '0' + m : m;
      d = d < 10 ? '0' + d : d;
      H = H < 10 ? '0' + H : H;
      M = M < 10 ? '0' + M : M;
      S = S < 10 ? '0' + S : S;
      return `${y}-${m}-${d} ${H}:${M}:${S}`
    }
  },
  methods: {
    alipayresultHandler() {
      // 转发支付宝支付结果给后端服务器
      this.$axios.get(`${this.$settings.HOST}/payments/alipay/result/` + location.search).then(response => {
        this.$message({message: response.data.message, type: "success"});
        localStorage.user_credit = response.data.credit;
        sessionStorage.user_credit = response.data.credit;
        this.pay_time = response.data.pay_time;
        this.real_price = response.data.real_price;
        this.course_list = response.data.course_list;

      }).catch(error => {
        this.$message({message: error.response.data.message, type: "error"});
        // 支付失败时，会出现挑来跳去的死循环
        // this.$router.go(-1)
      })
    },
  },
  components: {
    Header,
    Footer,
  }
}
</script>

<style scoped>
.success {
  padding-top: 80px;
}

.main {
  height: 100%;
  padding-top: 25px;
  padding-bottom: 25px;
  margin: 0 auto;
  width: 1200px;
  background: #fff;
}

.main .title {
  display: flex;
  -ms-flex-align: center;
  align-items: center;
  padding: 25px 40px;
  border-bottom: 1px solid #f2f2f2;
}

.main .title .success-tips {
  box-sizing: border-box;
}

.title img {
  vertical-align: middle;
  width: 60px;
  height: 60px;
  margin-left: 40px;
}

.title .success-tips {
  box-sizing: border-box;
}

.title .tips1 {
  font-size: 22px;
  color: #000;
}

.title .tips2 {
  font-size: 16px;
  color: #4a4a4a;
  letter-spacing: 0;
  text-align: center;
  margin-top: 10px;
}

.title .tips2 span {
  color: #ec6730;
}

.order-info {
  padding: 25px 48px;
  padding-bottom: 15px;
  border-bottom: 1px solid #f2f2f2;
}

.order-info p {
  font-family: PingFangSC-Regular;
  display: -ms-flexbox;
  display: flex;
  margin-bottom: 10px;
  font-size: 16px;
}

.order-info p b {
  font-weight: 400;
  color: #9d9d9d;
  white-space: nowrap;
}

.wechat-code {
  display: flex;
  -ms-flex-align: center;
  align-items: center;
  padding: 25px 40px;
  border-bottom: 1px solid #f2f2f2;
}

.wechat-code > img {
  width: 100px;
  height: 100px;
  margin-left: 15px;
}

.wechat-code p {
  font-family: PingFangSC-Regular;
  font-size: 14px;
  color: #d0021b;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-align: center;
  align-items: center;
}

.wechat-code p > img {
  width: 16px;
  height: 16px;
  margin-left: 10px;
}

.study {
  padding: 25px 40px;
}

.study span {
  display: block;
  width: 140px;
  height: 42px;
  text-align: center;
  line-height: 42px;
  cursor: pointer;
  background: #ffc210;
  border-radius: 6px;
  font-family: PingFangSC-Regular;
  font-size: 16px;
  color: #fff;
}
</style>
