<template>
  <div class="login box">
    <img src="../../static/image/Loginbg.3377d0c.jpg" alt="" />
    <div class="login">
      <div class="login-title">
        <img src="../../static/image/logo.png" alt="" />
        <p>جاسىمدا عىلىم بار دەپ ەسكەرمەدىم.</p>
      </div>
      <div class="login_box">
        <div class="title">
          <span class="active">ەلحات ارقىلى قايتارىپ الۋ </span>
        </div>
        <div class="inp">
          <input v-model="email" type="text" @blur="checkEmail" placeholder="ەلحات ءادىرىسى " class="user" />
          <div class="sms-box"> <input v-model="mail_code" type="text" maxlength="6" placeholder="ەلحات دالەلدەۋ كودى " class="user" />
            <div class="sms-btn" @click="getMail">{{ sms_text }}</div>
          </div>

          <div id="geetest1"></div>

          <button class="login_btn" @click="validMailHandler">قۇپيا سيفردى</button>
          <p class="go_login">
            تىزىمدەلمەگەن <router-link to="/user/reg">دەرەۋ تىزىمدەلەيىن</router-link>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Validmail",
  data() {
    return {
      mail_code: "",
      email: "",
      sms_text: "دالەلدەۋ كودىن جىبەرۋ ",
      is_send_mail: false // 发送邮箱验证的判断标标识
    };
  },
  created() {
    this.captcha = false;
  },
  methods: {
    checkEmail() {
      //1. 邮箱地址空值检测
      if (this.email == "") {
        this.$message.error("ەلحات ءادىرىسى بوس بولماسىن ");
      }
      // 2.检测60秒内是否发送邮箱验证码
      if (this.is_send_mail) {
        this.$message.error("دالەلدەۋ كودى جىبەرىلدى 60 دەكۋند كۇتىڭىز");
        return false;
      }
      // 3.检测邮箱是否注册
      this.$axios
        .get(`${this.$settings.HOST}/user/mail/${this.email}/`)
        .then(response => {
          console.log(response.data);
        })
        .catch(error => {
          this.$message.error(error.response.data.message);
        });
    },
    getMail() {
      // 发送邮箱
      this.$axios
        .post(`${this.$settings.HOST}/user/mail/${this.email}/`)
        .then(response => {
          console.log(response.data);
          this.is_send_mail = true;
          let interval_time = 60;
          let timer = setInterval(() => {
            if (interval_time < 1) {
              // 停止倒计时，允许用户发送短信
              clearInterval(timer);
              this.is_send_mail = false; // 重新设置发送短信的间隔状态为false，允许再次发送短信
              this.sms_text = "دالەلدەۋ كودىن جىبەرۋ ";
            } else {
              interval_time--;
              this.sms_text = `${interval_time}سەكۋندتان كەيىن قايتا جولداۋعا بولادى `;
            }
          }, 1000);
        })
        .catch(error => {
          this.$message.error(error.response.data.message);
        });
    },
    validMailHandler() {
      this.$axios .get( `${this.$settings.HOST}/user/validmail/${this.email}/${this.mail_code}` ) .then(response => {
          console.log(response.data);
          sessionStorage.removeItem("user_id");
          sessionStorage.removeItem("user_token");
          sessionStorage.removeItem("user_name");
          sessionStorage.user_id = response.data.id;
          sessionStorage.user_token = response.data.token;
          sessionStorage.user_name = response.data.username;

          // 页面跳转
          let self = this;
          this.$alert("دالەلدەۋ ءساتتى بولدى ", "دۋدار ساباقحاناسى", {
            callback() {
              self.$router.push("/user/repassword/");
            }
          }).catch(error => {
            this.$message.error(error.response.data.message);
          });
        });
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
  font-family: PingFangSC-Regular;
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

.login_box .title .active {
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
