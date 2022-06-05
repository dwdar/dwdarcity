<template>
  <div class="user-order">
    <Header/>
    <div class="main">
      <div class="banner"></div>
      <div class="profile">
        <div class="profile-info">
          <div class="avatar"><img class="newImg" width="100%" alt="" src="/static/image/logo@2x.png"></div>
          <span class="user-name">Dwdar</span>
          <span class="user-job">شينجياڭ | سانجى | مۇعالىم </span>
        </div>
        <ul class="my-item">
          <li>مۇشەلىك ماتەريال </li>
          <li class="active">تاپسىرىستارىم  </li>
          <li>جەكەلىك ماتەريال </li>
          <li>مۇشەلىك حاۋىپسىزدىك </li>
        </ul>
      </div>
      <div class="user-data">
        <ul class="nav">
          <li class="order-info">تاپسىرىس </li>
          <li class="course-expire">مەرزىمى</li>
          <li class="course-price">ساباق </li>
          <li class="real-price">سوماسى </li>
          <li class="order-status">جاعدايى </li>
          <li class="order-do">مەڭگەرۋ</li>
        </ul>
        <div class="my-order-item" v-for="order in order_list" :key="order.id">
          <div class="user-data-header">
            <span class="order-time">{{ order.create_time|timeformat }}</span>
            <span class="order-num">ءنومىرى: <span class="my-older-number">{{ order.order_number }}</span></span>
          </div>
          <ul class="nav user-data-list" v-for="course in order.course_list" :key="course.id">
            <li class="order-info">
              <img :src="course.course_img" alt="">
              <div class="order-info-title">
                <p class="course-title">{{ course.name }}</p>
                <p class="price-service" v-show="course.discount_name">{{ course.discount_name }}</p>
              </div>
            </li>
            <li class="course-expire">{{ course.expire_text }}</li>
            <li class="course-price">¥{{ course.price.toFixed(2) }}</li>
            <li class="real-price">¥{{ course.real_price.toFixed(2) }}</li>
            <li class="order-status" v-if="order.order_status===0">تولەنبەگەن </li>
            <li class="order-status" v-if="order.order_status===1">تولەنىپ بولعان </li>
            <li class="order-status" v-if="order.order_status===2">كۇشىنەن قالعان </li>
            <li class="order-status" v-if="order.order_status===3">ۋاقىتى وتكەن </li>
            <li class="order-do" v-if="order.order_status===0">
              <span class="btn btn2" @click="gotopay(order.order_number)">اقى تولەيىن </span>
            </li>
            <li class="order-do" v-if="order.order_status===1">
              <router-link to="/study/"><span class="btn btn3">ۇيرەنەمىن</span></router-link>
            </li>
            <li class="order-do" v-if="order.order_status===2">
              <router-link :to="'/course/detail/'+course.id"><span class="btn btn4">قايتادان ساتىپ الۋ </span></router-link>
            </li>
            <li class="order-do" v-if="order.order_status===3">
              <router-link :to="'/course/detail/'+course.id"><span class="btn btn4">قايتادان ساتىپ الۋ </span></router-link>
            </li>
          </ul>
        </div>

      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "./common/Header"
import Footer from "./common/Footer"

export default {
  name: "UserOrder",
  data() {
    return {
      order_list: []
    };
  },
  created() {
    this.check_user_login();
    this.get_user_order();
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
    check_user_login() {
      // 验证登录
      let token = localStorage.user_token || sessionStorage.user_token
      if (!token) {
        let self = this
        this.$confirm('浏览此页面需要登录', 'dwdar学城', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning',
        }).then(() => {
          self.$router.push('/user/login')
        })
        return false
      }
      return token
    },
    get_user_order() {
      //  获取用户订单数据
      let token = this.check_user_login();
      this.$axios.get(`${this.$settings.HOST}/user/order/`, {
        headers: {
          Authorization: 'jwt ' + token,
        },
      }).then(response => {
        // console.log(response.data)
        this.order_list = response.data;
      }).catch(error => {
        console.log(error.response)
      })
    },
    gotopay(order_number) {
      //  生成支付订单的链接地址
      // 发起支付【页面跳转，后端提供跳转地址】
      this.$axios.get(`${this.$settings.HOST}/payments/alipay/`, {
        params: {
          order_number: order_number
        }
      }).then(response => {
        //返回支付链接地址
        location.href = response.data

      }).catch(error => {
        this.$message({
          message: error.response.message,
          type: "error"
        })
      })
      // console.log(response.data)
    }
  },
  components: {
    Header,
    Footer,
  }
}
</script>

<style scoped>
.user-order {
  padding-top: 80px;
}

.main .banner {
  width: 100%;
  height: 324px;
  background: url(/static/image/my_bkging.0648ebe.png) no-repeat;
  background-size: cover;
  z-index: 1;
}

.profile {
  width: 1200px;
  margin: 0 auto;
}

.profile-info {
  text-align: center;
  margin-top: -80px;
}

.avatar {
  width: 120px;
  height: 120px;
  border-radius: 60px;
  overflow: hidden;
  margin: 0 auto;
}

.user-name {
  display: block;
  font-size: 24px;
  color: #4a4a4a;
  margin-top: 14px;
}

.user-job {
  display: block;
  font-size: 11px;
  color: #9b9b9b;
}

.my-item {
  list-style: none;
  line-height: 1.42857143;
  color: #333;
  width: 474px;
  height: 31px;
  display: -ms-flexbox;
  display: flex;
  cursor: pointer;
  margin: 41px auto 0;
  -ms-flex-pack: justify;
  justify-content: space-between;
}

.my-item .active {
  border-bottom: 1px solid #000;
}

.user-data {
  width: 1200px;
  height: auto;
  margin: 0 auto;
  padding-top: 30px;
  border-top: 1px solid #e8e8e8;
  margin-bottom: 63px;
}

.nav {
  width: 100%;
  height: 60px;
  background: #e9e9e9;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-align: center;
  align-items: center;
}

.nav li {
  margin-right: 20px;
  margin-left: 28px;
  height: 60px;
  line-height: 60px;
  list-style: none;
  font-family: KazakhSoft Qaniq;
  font-size: 13px;
  color: #333;
  border-bottom: 1px solid #e9e9e9;
  width: 120px;
}

.nav .order-info {
  width: 325px;
}

.nav .course-expire {
  width: 60px;
}

.nav .course-price {
  width: 130px;
}

.user-data-header {
  display: flex;
  height: 44px;
  color: #4a4a4a;
  font-size: 14px;
  background: #f3f3f3;
  -ms-flex-align: center;
  align-items: center;
  font-family: KazakhSoft Qaniq;
}

.order-time {
  font-size: 12px;
  display: inline-block;
  margin-right: 20px;
}

.order-num {
  font-size: 12px;
  display: inline-block;
  margin-right: 29px;
}

.user-data-list {
  height: 100%;
  display: flex;
}

.user-data-list {
  background: none;
}

.user-data-list li {
  height: 60px;
  line-height: 60px;
}

.user-data-list .order-info {
  display: flex;
  align-items: center;
  margin-left: 28px;
}

.user-data-list .order-info img {
  max-width: 100px;
  max-height: 75px;
  margin-left: 22px;
}

.course-title {
  width: 203px;
  font-size: 13px;
  color: #333;
  line-height: 20px;
  font-family: KazakhSoft Qaniq;
  margin-top: -10px;
}

.order-info-title .price-service {
  line-height: 18px;
}

.price-service {
  font-size: 12px;
  color: #fa6240;
  padding: 0 5px;
  border: 1px solid #fa6240;
  border-radius: 4px;
  margin-top: 4px;
  position: absolute;
}

.order-info-title {
  margin-top: -10px;
}

.user-data-list .course-expire {
  font-size: 12px;
  color: #ff5502;
  font-family: KazakhSoft Qaniq;
  width: 60px;

  text-align: center;
}

.btn {
  width: 100px;
  height: 32px;
  font-size: 14px;
  color: #fff;
  background: #ffc210;
  border-radius: 4px;
  border: none;
  outline: none;
  font-family: KazakhSoft Qaniq;
  transition: all .25s ease;
  display: inline-block;
  line-height: 32px;
  text-align: center;
  cursor: pointer;
}

.btn3 {
  background-color: green;
}

.btn4 {
  background-color: #9d9d9d;
}
</style>
