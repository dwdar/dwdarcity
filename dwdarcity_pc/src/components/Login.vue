<template>
  <div class="login box">
    <img src="../../static/image/Loginbg.3377d0c.jpg" alt="" />
    <div class="login">
      <div class="login-title">
        <img src="../../static/image/logo.png" alt="" />
        <p>جاسىمدا عىلىم بار دەپ ەسكەرمەدىم...</p>
      </div>
      <div class="login_box">
        <div class="title">
          <span @click="login_type = 0" :class="{active:login_type==0}">قۇپيا سيفرمەن </span>
          <span @click="login_type = 1" :class="{active:login_type==1}">كەلتەحاتپەن </span>
        </div>
        <div class="inp" v-if="login_type == 0">
          <input v-model="username" type="text" placeholder="مۇشەلىك ەسىم / قولفون ءنومىر " class="user" />

          <input v-model="password" type="password" name="" class="pwd" placeholder="قۇپيا سيفر " />
          <div id="geetest1"></div>
          <div class="rember">
            <p> <input type="checkbox" class="no" v-model="remember" /> <span>ەستە ساقتاۋ </span> </p>
            <!-- <p>قۇپيا سيفردى ۇمىتتىم</p> -->
            <router-link to="/user/validmail">قۇپيا سيفردى ۇمىتتىم</router-link>
          </div>
          <button class="login_btn" @click="loginHander">كىرۋ</button>
          <p class="go_login">مۇشە ەمەسپىن <router-link to="/user/reg">دەرۋ تىزىمدەلەيىن </router-link></p>
        </div>


          <!-- 短信登录 -->

        <div class="inp" v-show="login_type == 1">
          <input v-model="mobile" type="text" placeholder="قولفون ءنومىرى " class="user" />
          <div class="sms-box">
            <input v-model="sms_code" type="text" maxlength="6" placeholder="انىقتاۋ كودى" class="user" />
             <div class="sms-btn" @click="smsHandler">{{sms_text}}</div>
          </div>
          <button class="login_btn" @click="smsLoginHandler">كىرۋ</button>
          <p class="go_login">مۇشە ەمەسپىن  <router-link to="/user/reg">دەرۋ تىزىمدەلەيىن </router-link></p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Login",
  data() {
    return {
      login_type: 0,
      username: "",
      password: "",
      remember: false,
      sms_code: "",
      mobile: "",
      sms_text :"انىقتاۋ كودىن جىبەر",
      is_send_sms: false // 发送短信的判断标标识
    };
  },
  created() {
    this.captcha = false;
  },
  methods: {
    smsHandler() {
      // 发送短信
      // 1、检测手机号码格式
      if (!/^1[3|4|5|7|8]\d{9}$/.test(this.mobile)) {
        console.log(this.mobile);
        this.$message.error("قولفون ءنومىرى قاتە ");
        return false;
      }
      // 2、判断手机号码是否60s内发送短信
      if (this.is_send_sms) {
        this.$message.error("قولفونعا كەلتەحات جىبەرىلدى 60 دەكۋندتان كەيىن قايتا جىبەرۋگە بولادى");
        return false;
      }
      // 3、发送ajax
      this.$axios .get(`${this.$settings.HOST}/user/sms/${this.mobile}/`) .then(response => {
          console.log(response.data);
          this.is_send_sms = true;
          let interval_time = 60;
          let timer = setInterval(() => {
            if (interval_time < 1) {
              // 停止倒计时，允许用户发送短信
              clearInterval(timer);
              this.is_send_sms = false; // 重新设置发送短信的间隔状态为false，允许再次发送短信
              this.sms_text = "انىقتاۋ كودىن جىبەر";
            } else {
              interval_time--;
              this.sms_text = `${interval_time}سەكۋندتان كەيىن قايتا جولداۋعا بولادى `
            }
          }, 1000);
        }) .catch(error=>{
          this.$message.error(error.response.data.message)
        });
    },
    loginHander() {
      this.$axios .post(`${this.$settings.HOST}/user/login/`, { username: this.username, password: this.password, }) .then((response) => {
          if (this.remember) {
            //  记录登录状态
            localStorage.removeItem("user_id");
            localStorage.removeItem("user_token");
            localStorage.removeItem("user_name");
            localStorage.removeItem("user_credit");
            localStorage.removeItem("credit_to_money");
            localStorage.user_id = response.data.id;
            localStorage.user_token = response.data.token;
            localStorage.user_name = response.data.username;
            localStorage.user_credit = response.data.user_credit;
            localStorage.credit_to_money = response.data.credit_to_money;
          } else {
            //  不记录登录状态
            sessionStorage.removeItem("user_id");
            sessionStorage.removeItem("user_token");
            sessionStorage.removeItem("user_name");
            sessionStorage.removeItem("user_credit");
            sessionStorage.removeItem("credit_to_money");
            sessionStorage.user_id = response.data.id;
            sessionStorage.user_token = response.data.token;
            sessionStorage.user_name = response.data.username;
            sessionStorage.user_credit = response.data.user_credit;
            sessionStorage.credit_to_money = response.data.credit_to_money;
          }
          //  登录成功后页面跳转
          let self = this;
          this.$alert("ءساتتى تىركەلدىڭىز", "Dwdar ساباقحاناسى", {
            callback() {
            //   self.$router.push("/");
            self.$router.go('-1');
            },
          });
        })
        .catch((error) => {
          this.$message({
            message: "مۇشەلىك ەسىم نەمەسە قۇپيا سيفر قاتە بولدى",
            type: "error",
          });
        });
    },
    smsLoginHandler(){
      this.$axios .get(`${this.$settings.HOST}/user/sms_login/${this.mobile}/${this.sms_code}/`).then(response=>{

        localStorage.removeItem("user_id");
        localStorage.removeItem("user_token");
        localStorage.removeItem("user_name");
        localStorage.removeItem("user_credit");
        localStorage.removeItem("credit_to_money");
        localStorage.user_id = response.data.id;
        localStorage.user_token = response.data.token;
        localStorage.user_name = response.data.username;
        localStorage.user_credit = response.data.user_credit;
        localStorage.credit_to_money = response.data.credit_to_money;

        //  登录成功后页面跳转
          let self = this;
          this.$alert("حوش كەلدىڭىز", "Dwdar ساباقحاناسى", {
            callback() {
              self.$router.push("/");
            },
          });
      }).catch(error=>{
        console.log(error.response);
      })
    }
  }
};
</script>

<style scoped>
.box {
  width: 100%;
  height: 100%;
  position: relative;
  overflow: hidden;
  direction:rtl;
}

.box img {
  width: 100%;
  min-height: 100%;
}

.box .login {
  position: absolute;
  width: 500px;
  height: 400px;
  top: 0;
  right: 0;
  margin: auto;
  left: 0;
  bottom: 0;
  top: -338px;
}

.login .login-title {
  width: 100%;
  text-align: center;
}

.login-title img {
  width: 190px;
  height: auto;
}

.login-title p {
  font-family: ALKATIP Basma Tom;
  font-size: 18px;
  color: #fff;
  letter-spacing: 0.29px;
  padding-top: 10px;
  padding-bottom: 50px;
}

.login_box {
  width: 400px;
  height: auto;
  background: #fff;
  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.5);
  border-radius: 4px;
  margin: 0 auto;
  padding-bottom: 40px;

}

.login_box .title {
  font-size: 20px;
  color: #9b9b9b;
  letter-spacing: 0.32px;
  border-bottom: 1px solid #e6e6e6;
  display: flex;
  justify-content: space-around;
  padding: 50px 60px 0 60px;
  margin-bottom: 20px;
  cursor: pointer;
}

/* .login_box .title span:nth-of-type(1) {
  color: #4a4a4a;
  border-bottom: 2px solid #84cc39;
} */

.login_box .title .active{
  color: #4a4a4a;
  border-bottom: 2px solid #84cc39;
}

.inp {
  width: 350px;
  margin: 0 auto;
}

.inp input {
  border: 0;
  outline: 0;
  width: 100%;
  height: 45px;
  border-radius: 4px;
  border: 1px solid #d9d9d9;
  text-indent: 20px;
  font-size: 14px;
  background: #fff !important;
}

.inp input.user {
  margin-bottom: 16px;
}

.inp .rember {
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: relative;
  margin-top: 10px;
}

.inp .rember p:first-of-type {
  font-size: 12px;
  color: #4a4a4a;
  letter-spacing: 0.19px;
  margin-right: 22px;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-align: center;
  align-items: center;
  /*position: relative;*/
}

.inp .rember p:nth-of-type(2) {
  font-size: 14px;
  color: #9b9b9b;
  letter-spacing: 0.19px;
  cursor: pointer;
}

.inp .rember input {
  outline: 0;
  width: 15px;
  height: 45px;
  border-radius: 4px;
  border: 1px solid #d9d9d9;
  text-indent: 20px;
  font-size: 14px;
  background: #fff !important;
}

.inp .rember p span {
  display: inline-block;
  font-size: 12px;
  width: 100px;
  margin-right:8px;
  /*position: absolute;*/
  /*right: 20px;*/
}

#geetest {
  margin-top: 20px;
}

.login_btn {
  width: 100%;
  height: 45px;
  background: #84cc39;
  border-radius: 5px;
  font-size: 16px;
  color: #fff;
  letter-spacing: 0.26px;
  margin-top: 30px;
  font-family: ALKATIP Basma Tom;
}

.inp .go_login {
  text-align: center;
  font-size: 14px;
  color: #9b9b9b;
  letter-spacing: 0.26px;
  padding-top: 20px;
}

.inp .go_login span {
  color: #84cc39;
  cursor: pointer;
}

#geetest1 span button {
  margin-top: 10px;
  height: 30px;
  line-height: 30px;
  width: 100%;
}

.sms-box {
  position: relative;
}
.sms-box .sms-btn {
  position: absolute;
  font-size: 14px;
  letter-spacing: 0.26px;
  top: 10px;
  left: 16px;
  border-right: 1px solid #484848;
  padding-right: 16px;
  padding-bottom: 4px;
  cursor: pointer;
  background-color: #fff;
  overflow: hidden;
}
</style>
