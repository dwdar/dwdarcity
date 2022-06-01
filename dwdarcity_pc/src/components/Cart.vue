<template>
  <div class="cart">
    <Header></Header>
    <div class="cart_info">
      <div class="cart_title">
        <span class="text">مەنىڭ سەبەتىم</span>
        <span class="total">جيىنى {{$store.state.cart_length}}ساباق بار</span>
      </div>
      <div class="cart_table">
        <div class="cart_head_row">
          <span class="doing_row"></span>
          <span class="course_row">ساباق </span>
          <span class="expire_row">كۇشكە يە مەرزىم </span>
          <span class="price_row">جەكە باعاسى </span>
          <span class="do_more">مەڭگەرۋ </span>
        </div>
        <!-- 购物车中商品列表 -->
        <div class="cart_course_list">
          <CartItem v-for="(course,key) in course_list" :key="key" @change_select="calc_total" :course="course" @delete_course="del_cart(key)"></CartItem>
        </div>
        <div class="cart_footer_row">
          <span class="cart_select"><label>
              <el-checkbox v-model="checked"></el-checkbox><span>ءبارىن تاڭداۋ</span>
            </label></span>
          <span class="cart_delete"><i class="el-icon-delete"></i> <span>ءوشىرۋ </span></span>
         <router-link to="/order"> <span class="goto_pay">ەسەپ جاساۋ </span></router-link>
          <span class="cart_total">جالپى سوما:{{total_price.toFixed(2)}} ¥</span>
        </div>
      </div>
    </div>
    <Footer></Footer>
  </div>
</template>

<script>
import Header from './common/Header'
import Footer from './common/Footer'
import CartItem from './common/CartItem'
export default {
  name: 'Cart',
  data() {
    return {
      checked: false,
      token: '',
      course_list: [],
      total_price: 0,
    }
  },
  created() {
    this.token = this.check_user_login()
    this.get_cart()
  },
  methods: {
    //   计算总价
    calc_total() {
      // 计算购物车中勾选商品的总价格
      let total = 0
      this.course_list.forEach((course, key) => {
        if (course.selected) {
          total += parseFloat(course.price)
        }
      })
      this.total_price = total
    },
    check_user_login() {
      // 验证登录
      let token = localStorage.user_token || sessionStorage.user_token
      if (!token) {
        let self = this
        this.$confirm('سەبەتتى پايدالانۋ ءۇشىن سايتقا كىرۋ كەرەك', 'دۋدار ساباقحاناسى', {
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

    get_cart() {
      // 获取购物车数据
      this.$axios
        .get(`${this.$settings.HOST}/cart/`, {
          headers: {
            //  提交jwt 的时候，必须向后端声明该token 由jwt 生成的
            Authorization: 'jwt ' + this.token,
          },
        })
        .then((response) => {
          this.course_list = response.data
          // console.log('cart课程列表',response.data)
          this.$store.commit('add_cart', this.course_list.length)
          // 购物车数据成功获取之后，前段统计勾选商品的总价格
          this.calc_total()
        })
        .catch((error) => {
          console.log(error.response)
        })
    },
    del_cart(key) {
        // 前段删除
        this.course_list.splice(key,1);
        // 删除商品后重新计算总价格
        // this.calc_total();

    }
  },
  components: {
    Header,
    Footer,
    CartItem,
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
  width: 188px;
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
  color: #666;
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
</style>
