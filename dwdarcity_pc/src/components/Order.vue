<template>
  <div class="cart">
    <Header></Header>
    <div class="cart_info">
      <div class="cart_title">
        <span class="text">مەنىڭ زاكازدارىم</span>
        <span class="total">جيىنى {{ course_list.length }}ساباق بار</span>
      </div>
      <div class="cart_table">
        <div class="cart_head_row">
          <span class="course_row">ساباق </span>
          <span class="expire_row">كۇشكە يە مەرزىم </span>
          <span class="do_more">مەڭگەرۋ</span>
        </div>
        <!-- 购物车中商品列表 -->
        <div class="cart_course_list">
          <div class="cart_item" v-for="course in course_list" :key="course.id">
            <div class="cart_column column_2"><img :src="course.course_img" alt="">
              <div class="course_names">
                <span class="course_name">{{ course.name }}</span><br>
                <span class="discount_name">{{ course.discount_name }}</span>
              </div>

            </div>
            <div class="cart_column column_3">
              <span>{{ course.expire_text }}</span>
            </div>
            <div class="cart_column column_4">
              <span class="real_price">¥{{ course.real_price }}</span><br>
              <span class="original_price">¥{{ course.orginal_price }}</span>
            </div>
          </div>
        </div>
        <!-- 购物车中商品列表 -->

        <!-- 优惠券 -->

        <div class="discount">
          <div id="accordion">
            <div class="coupon-box">
              <div class="icon-box">
                <span class="select-coupon">تيىمدىلىك بەلەتتى جۇمساۋ:</span>

                <label class="select-icon unselect">
                  <el-checkbox v-model="use_coupon"></el-checkbox>
                  <p v-if="!use_coupon"></p></label>

                <span class="coupon-num">جۇمساۋعا بولاتىنى {{ coupon_list.length }}دانا </span>
              </div>
              <p class="sum-price-wrap">جالپى سوماسى <span class="sum-price">¥{{ total_price.toFixed(2) }}يۋان </span></p>
            </div>
            <div id="collapseOne"
                 v-if="use_coupon">
              <ul class="coupon-list"
                  v-if="coupon_list.length>0">

                <li class="coupon-item" :class="selected_coupon(key,item.id)" v-for="(item,key) in coupon_list"
                    :key="key" @click="click_select_coupon(key,item.id)">
                  <p class="coupon-name">{{ item.coupon.name }}</p>
                  <p class="coupon-condition"
                     v-if="item.coupon.condition>0">{{ item.coupon.condition }} يۋانعا تولسا جۇمسالادى</p>
                  <p class="coupon-condition"
                     v-else>زات السا جۇمسالادى </p>
                  <p class="coupon-time start_time">باستالۋى:{{ item.start_time.replace("T", " ") }}</p>
                  <p class="coupon-time end_time">اياقتالۋى: {{ item.end_time }}</p>
                </li>

              </ul>
              <div class="no-coupon"
                   v-if="coupon_list.length<1">
                <span class="no-coupon-tips">جۇمساۋعا بولاتىن بەلەت جوق </span>
              </div>
            </div>
          </div>
          <!-- 优惠券 -->

          <!-- 积分 -->
          <div><p class="discount-num1" v-if="use_coupon"> اڭداتپا: تيىمدىلىك بەلەتى مەن جارماقتى بىردەي پايدالانۋ كەرەك بولعاندا الدىمەن بەلەتتى جۇمساڭىز.</p></div>
          <div class="credit-box">
            <label class="my_el_check_box">
              <el-checkbox class="my_el_checkbox" v-model="use_credit"></el-checkbox>
            </label>
            <p class="discount-num1" v-if="!use_credit">جارماقتى جۇمساۋ </p>
            <p class="discount-num2" v-else>
              <span>بار بولعانى  {{ user_credit }}جارماق، جۇمسايتىنىڭىز <el-input-number @change="handleChange"
                                                                                            v-model="credit" :min="0"
                                                                                            :max="max_credit()"
                                                                                            label="جۇمسايتىن جارماقتىڭ سانى"></el-input-number>اسىپ قالعان جارماقتىڭ سانى {{
                parseInt(user_credit - credit)
              }}جارماق</span>
            </p>

          </div>
          <p class="sun-coupon-num">تيىمدىلىك بەلەتتەن كوتەرىلگەنى  <span>0.00 يۋان</span></p>
        </div>
        <!-- 积分 -->

        <!-- 支付 -->
        <div class="cart_footer_row">
          <span class="pay_col"> <label><span>اقى تولەۋ ءتاسىلى: </span></label> </span>
          <span class="pay_type" v-if="pay_type==0"><img src="../../static/image/alipay2.png" alt=""></span>
          <span class="pay_type" v-else @click="pay_type=0"><img src="../../static/image/alipay.png" alt=""></span>
          <span class="pay_type" v-if="pay_type==1"><img src="../../static/image/wechat2.png" alt=""></span>
          <span class="pay_type" v-else @click="pay_type=1"><img src="../../static/image/wechat.png" alt=""></span>
          <span class="goto_pay" @click="payHandler"><router-link to="/order">اقى تولەۋ </router-link></span>
          <span class="cart_total">تولەيتىن سوما <strong>¥{{ (real_total - credit / credit_to_money).toFixed(2) }}</strong></span>
        </div>
        <!-- 支付 -->

      </div>

    </div>
    <Footer></Footer>
  </div>
</template>


<script>
import Header from './common/Header'
import Footer from './common/Footer'

export default {
  name: 'Order',
  data() {
    return {
      pay_type: 0, // 总价格
      course_list: [], // 勾选商品列表
      total_price: 0, // 结算的总价格
      real_total: 0, // 经过优惠券折算或者积分折算后的总价格
      coupon_list: [], // 当前用户拥有的优惠券列表

      use_credit: false, // 是否使用了积分
      use_coupon: false, // 是否使用优了惠券
      credit: 0, // 积分
      coupon: 0, // 优惠券
      user_credit: localStorage.user_credit || sessionStorage.user_credit,
      credit_to_money: localStorage.credit_to_money || sessionStorage.credit_to_money,
    }
  },
  components: {
    Header,
    Footer,
  },
  created() {
    this.get_cart();
    this.get_coupon();
  },
  watch: {
    coupon() {
      // 监听优惠券变动情况，重新计算总价格
      this.credit = 0;
      this.calc_real_total();
    },
    use_coupon() {
      // 监听使用优惠券勾选，重新计算总价格
      if (this.use_coupon === false) {
        this.coupon = 0;
        this.real_total = this.total_price;
      }
    },
    use_credit() {
      // 监听使用积分，重新计算总价
      this.credit = 0;
      this.calc_real_total();
    }
  },
  methods: {
    get_cart() {
      // 获取购物车中要结算的商品信息
      let token = sessionStorage.user_token || localStorage.user_token
      this.$axios
        .get(`${this.$settings.HOST}/cart/order/`, {
          headers: {
            Authorization: 'jwt ' + token,
          },
        })
        .then((response) => {
          console.log(response.data)
          this.course_list = response.data.course_list
          this.total_price = response.data.total_price
          this.real_total = response.data.total_price
        })
        .catch((error) => {
          this.$message({
            message: error.response.message,
            type: 'error',
          })
        })
    },
    get_coupon() {
      // 获取用户优惠券
      let token = sessionStorage.user_token || localStorage.user_token
      this.$axios
        .get(`${this.$settings.HOST}/coupon/`, {
          headers: {
            Authorization: 'jwt ' + token,
          },
        })
        .then((response) => {
          this.coupon_list = response.data
        })
        .catch((error) => {
          this.$message({
            message: error.response.message,
            type: 'error',
          })
        })
    },
    selected_coupon(key, user_coupon_id) {
      // 当选中优惠券时，切换优惠券的高亮显示效果
      let user_coupon = this.coupon_list[key]
      // 判断优惠券是否处于使用范围内
      if (this.total_price < user_coupon.coupon.condition) {
        return 'disable'
      }
      // 判断总价格是否处于使用范围内
      let start_timestamp = parseInt(new Date(user_coupon.start_time) / 1000) // 开始时间戳取整
      let end_timestamp = parseInt(new Date(user_coupon.end_time) / 1000) // 结束时间戳取整
      let now_timestamp = parseInt(new Date() / 1000) // 当前时间戳取整

      if (now_timestamp < start_timestamp || now_timestamp > end_timestamp) {
        return 'disable'
      }

      if (this.coupon === user_coupon_id) {
        return 'active'
      } else {
        return ''
      }
    },
    click_select_coupon(key, user_coupon_id) {
      // 点击切换优惠券时记录本次点击的优惠券
      let user_coupon = this.coupon_list[key];
      if (this.total_price < user_coupon.coupon.condition) {
        return false;
      }
      let start_timestamp = parseInt(new Date(user_coupon.start_time) / 1000) // 开始时间戳取整
      let end_timestamp = parseInt(new Date(user_coupon.end_time) / 1000) // 结束时间戳取整
      let now_timestamp = parseInt(new Date() / 1000) // 当前时间戳取整

      if (now_timestamp < start_timestamp || now_timestamp > end_timestamp) {
        return 'false'
      }
      this.coupon = user_coupon_id;

    },
    payHandler() {
      // 生成订单
      let token = localStorage.user_token || sessionStorage.user_token
      this.$axios.post(`${this.$settings.HOST}/order/`,
        {
          pay_type: this.pay_type, // 支付方式
          credit: this.credit, // 积分
          coupon: this.coupon, // 优惠券
        },
        {
          headers: {
            Authorization: 'jwt ' + token,
          },
        }
      )
        .then((response) => {
          this.$message({
            message: 'تاپسىرىس بەرىلىپ جاتىر!!!',
            type: 'success',
          });
          // 发起支付【页面跳转，后端提供跳转地址】
          this.$axios.get(`${this.$settings.HOST}/payments/alipay/`, {
            params: {
              order_number: response.data.order_number
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
          console.log(response.data)

        })
        .catch((error) => {
          this.$message({
            message: 'زاكاز بەرۋ ءساتسىز بولدى!',
            type: 'error',
          })
        })
    },
    calc_real_total() {
      this.coupon_list.forEach((item) => {
        //  选出当前选中的那一张优惠券
        if (item.id === this.coupon) {
          let start_timestamp = parseInt(new Date(item.start_time) / 1000) // 开始时间戳取整
          let end_timestamp = parseInt(new Date(item.end_time) / 1000) // 结束时间戳取整
          let now_timestamp = parseInt(new Date() / 1000) // 当前时间戳取整
          // 选出当前可以使用的优惠券
          if (
            this.total_price > item.coupon.condition &&
            now_timestamp > start_timestamp &&
            now_timestamp < end_timestamp
          ) {
            // 根据优惠公式计算最终折算后的总价格
            //  获取优惠公式
            let f = parseFloat(item.coupon.sale.substr(1))

            if (item.coupon.sale[0] === '*') {
              // 折扣优惠
              this.real_total = this.total_price * f
            } else {
              // 减免优惠
              this.real_total = this.total_price - f
            }
          }
        }
      })
    },
    max_credit() {
      // 计算本次订单中用户可以设置的最大积分值

      // 用户拥有的积分，允许抵扣的最大金额
      let max_credit_to_money = this.user_credit / this.credit_to_money;
      console.log("ەڭ كوپ بولعاندا جۇمساۋعا بولاتىن جارماق سانى", max_credit_to_money);

      // 计算当前真实的订单支付金额

      let ret = 0;
      if (max_credit_to_money > this.real_total) {
        ret = parseInt(this.real_total * this.credit_to_money);
      } else {
        ret = parseInt(this.user_credit);
      }
      return ret
    },
    handleChange(value) {
      if (!value) {
        this.credit = 0;
      }
    }

  },
}
</script>

<style scoped>
.cart_info {
  width: 1200px;
  margin: 0 auto 200px;
}

.cart_title {
  margin: 25px 0;
}

.cart_title .text {
  font-size: 18px;
  color: #666;
}

.cart_title .total {
  font-size: 12px;
  color: #d0d0d0;
}

.cart_table {
  width: 1170px;
}

.cart_table .cart_head_row {
  background: #f7f7f7;
  width: 100%;
  height: 80px;
  line-height: 80px;
  padding-left: 30px;
}

.cart_table .cart_head_row::after {
  content: '';
  display: block;
  clear: both;
}

.cart_table .cart_head_row .doing_row,
.cart_table .cart_head_row .course_row,
.cart_table .cart_head_row .expire_row,
.cart_table .cart_head_row .price_row,
.cart_table .cart_head_row .do_more {
  padding-right: 10px;
  height: 80px;
  float: right;
}

.cart_table .cart_head_row .doing_row {
  width: 78px;
}

.cart_table .cart_head_row .course_row {
  width: 530px;
}

.cart_table .cart_head_row .expire_row {
  width: 300px;
}

.cart_table .cart_head_row .price_row {
  width: 162px;
}

.cart_table .cart_head_row .do_more {
  width: 162px;
}

.cart_footer_row {
  padding-right: 30px;
  background: #f7f7f7;
  width: 100%;
  height: 80px;
  line-height: 80px;
}

.cart_footer_row .cart_select span {
  margin-right: 7px;
  font-size: 18px;
  color: #666;
}

.cart_footer_row .cart_delete {
  margin-right: 58px;
}

.cart_delete .el-icon-delete {
  font-size: 18px;
}

.cart_delete span {
  margin-right: 15px;
  cursor: pointer;
  font-size: 18px;
  color: #666;
}

.cart_total {
  float: left;
  margin-left: 62px;
  font-size: 18px;
}

.cart_total strong {
  font-size: 30px;
}

.goto_pay {
  float: left;
  width: 159px;
  height: 80px;
  outline: none;
  border: none;
  background: #ffc210;
  font-size: 18px;
  color: #fff;
  text-align: center;
  cursor: pointer;
}

/*  cart-item */

.cart_item::after {
  content: '';
  display: block;
  clear: both;
}

.cart_column {
  float: right;
  height: 250px;
}

.cart_item .column_1 {
  width: 88px;
  position: relative;
}

.my_el_checkbox {
  position: absolute;
  right: 0;
  left: 0;
  bottom: 0;
  top: 0;
  margin: auto;
  width: 16px;
  height: 16px;
}

.cart_item .column_2 {
  padding: 32px 10px;
  width: 520px;
  height: 116px;
}

.cart_item .column_2 img {
  width: 175px;
  height: 115px;
  margin-left: 35px;
  vertical-align: middle;
}

.cart_item .column_3 {
  width: 197px;
  position: relative;
  padding-right: 10px;
}

.my_el_select {
  width: 117px;
  height: 28px;
  position: absolute;
  top: 0;
  bottom: 0;
  margin: auto;
}

.cart_item .column_3 {
  padding: 32px 10px;
  height: 116px;
  width: 300px;
  line-height: 116px;
}

.cart_item .column_4 {
  padding: 32px 10px;
  height: 116px;
  width: 120px;
  line-height: 30px;
  margin-top: 45px;
}

.cart_item .column_4 .real_price {
  font-size: 18px;
}

.cart_item .column_4 .original_price {
  color: dimgrey;
  text-decoration: line-through;
}

.course_names {
  display: inline-block;
  margin-top: 45px;
}

.discount_name {
  margin-top: 15px;
  color: #ffc210;
}

/* 优惠券相关 */

.coupon-box {
  text-align: right;
  padding-bottom: 22px;
  padding-right: 30px;
  border-bottom: 1px solid #e8e8e8;
}

.coupon-box::after {
  content: '';
  display: block;
  clear: both;
}

.icon-box {
  float: right;
}

.icon-box .select-coupon {
  float: right;
  color: #666;
  font-size: 16px;
}

.icon-box::after {
  content: '';
  clear: both;
  display: block;
}

.select-icon {
  width: 20px;
  height: 20px;
  float: right;
}

.select-icon img {
  max-height: 100%;
  max-width: 100%;
  margin-top: 2px;
  transform: rotate(-90deg);
  transition: transform 0.5s;
}

.is_show_select {
  transform: rotate(0deg) !important;
}

.coupon-num {
  height: 22px;
  line-height: 22px;
  padding: 0 5px;
  text-align: center;
  font-size: 12px;
  float: right;
  color: #fff;
  letter-spacing: 0.27px;
  background: #fa6240;
  border-radius: 2px;
  margin-right: 20px;
}

.sum-price-wrap {
  float: left;
  font-size: 16px;
  color: #4a4a4a;
  margin-left: 45px;
}

.sum-price-wrap .sum-price {
  font-size: 18px;
  color: #fa6240;
}

.no-coupon {
  text-align: center;
  width: 100%;
  padding: 50px 0px;
  align-items: center;
  justify-content: center; /* 文本两端对其 */
  border-bottom: 1px solid rgb(232, 232, 232);
}

.no-coupon-tips {
  font-size: 16px;
  color: #9b9b9b;
}

.credit-box {
  height: 30px;
  margin-top: 40px;
  display: flex;
  align-items: center;
  justify-content: flex-end;
}

.my_el_check_box {
  position: relative;
}

.my_el_checkbox {
  margin-left: 10px;
  width: 16px;
  height: 16px;
}

.discount {
  overflow: hidden;
}

.discount-num1 {
  color: #9b9b9b;
  font-size: 16px;
  margin-left: 45px;
}

.discount-num2 {
  margin-left: 45px;
  font-size: 16px;
  color: #4a4a4a;
}

.sun-coupon-num {
  margin-left: 45px;
  margin-bottom: 43px;
  margin-top: 40px;
  font-size: 16px;
  color: #4a4a4a;
  display: inline-block;
  float: left;
}

.sun-coupon-num span {
  font-size: 18px;
  color: #fa6240;
}

.coupon-list {
  margin: 20px 0;
}

.coupon-list::after {
  display: block;
  content: '';
  clear: both;
}

.coupon-item {
  float: right;
  margin: 15px 8px;
  width: 180px;
  height: 100px;
  padding: 5px;
  background-color: #fa3030;
  cursor: pointer;
}

.coupon-list .active {
  background-color: #fa9000;
}

.coupon-list .disable {
  cursor: not-allowed;
  background-color: #4a4a4a;
}

.coupon-condition {
  font-size: 12px;
  text-align: center;
  color: #fff;
}

.coupon-name {
  color: #fff;
  font-size: 24px;
  text-align: center;
}

.coupon-time {
  text-align: right;
  color: #fff;
  font-size: 12px;
}

.unselect {
  margin-right: 0px;
  transform: rotate(-90deg);
}

.is_selected {
  transform: rotate(-1turn) !important;
}
</style>
