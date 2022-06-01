<template>
  <div class="box">
    <img src="../../static/image/Loginbg.3377d0c.jpg" alt=""/>
    <div class="register">
      <div class="register_box">
        <div class="register-title">دۋدار ساباقحاناسىنا تىركەلۋ</div>
        <div class="inp">
          <input v-model="mobile" type="text" @blur="checkMobile" placeholder="قولفون ءنومىرى " class="user"/>
          <input v-model="password" type="password" placeholder="قۇپيا سيفر " class="user"/>
          <input v-model="re_password" type="password" placeholder="قۇپيا سيفرى انىقتاۋ " class="user" @blur="rePasswordHandler"/>
          <div class="sms-box">
            <input v-model="sms_code" type="text" maxlength="6" placeholder="انىقتاۋ كودى " class="user"/>
            <div class="sms-btn" @click="smsHandler">{{ sms_text }}</div>
          </div>
          <div id="geetest"></div>
          <button class="register_btn" @click="registerHandler">تىركەلۋ </button>
          <p class="go_login">
            بۇرىن تىركەلگەم
            <router-link to="/user/login">تىكە كىرەمىن </router-link>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Register",
  data() {
    return {
      sms_code: "",
      mobile: "",
      password: "",
      re_password: "",
      sms_text: "انىقتاۋ كودىن جىبەر ",
      is_send_sms: false // 发送短信的判断标标识
    };

    mo;
  },
  created() {
  },
  methods: {
    checkMobile() {
      //  后台检测手机号码是否被使用过mo
      this.$axios.get(`${this.$settings.HOST}/user/mobile/${this.mobile}`).then(response => {
      })
        .catch(error => {
          console.log(error.response)
          this.$message({
            message: "قولفون ءنومىرى دۇرىس جازىلماعان ",
            type: 'error'
          })
        });
    },
    rePasswordHandler() {
      // 前段教研两次输入的密码是否一直
      if (this.password != this.re_password) {
        this.password = "";
        this.re_password = "";
        this.$message({
          message: "قۇپيا سيفر بىردەي بولمادى ",
          typpe: "error"
        });
      }
    },
    registerHandler() {
      // 用户注册
      this.$axios.post(`${this.$settings.HOST}/user/reg/`, {
        mobile: this.mobile,
        sms_code: this.sms_code,
        password: this.password
      })
        .then(response => {
          sessionStorage.removeItem("user_id");
          sessionStorage.removeItem("user_token");
          sessionStorage.removeItem("user_name");
          sessionStorage.user_id = response.data.id;
          sessionStorage.user_token = response.data.token;
          sessionStorage.user_name = response.data.username;

          // 页面跳转
          let self = this;
          this.$alert("تىزىمدەۋ ءساتتى بولدى ", "دۋدارساباقحاناسى ", {
            callback() {
              self.$router.push("/");
            }
          });
        })
        .catch(error => {
          let data = error.response.data;
          let message = "";
          for (let key in data) {
            message = data[key][0];
          }
          this.$message({
            showClose: true,
            message: message,
            type: "error"
          });
        });
    },
    smsHandler() {
      // 发送短信

      // 1、检测手机号码格式
      if (!/^1[3|4|5|7|8]\d{9}$/.test(this.mobile)) {
        console.log(this.mobile);
        this.$message.error("قولفون ءنومىرى دۇرىس جازىلماعان ");
        return false;
      }
      // 2、判断手机号码是否60s内发送短信
      if (this.is_send_sms) {
        this.$message.error("قولفونعا كەلتەحان جولداندى، 60 سەكۋندتان كەيىن قايتا جولداۋعا بولادى ");
        return false;
      }
      // 3、发送ajax
      this.$axios.get(`${this.$settings.HOST}/user/sms/${this.mobile}/`).then(response => {
        console.log(response.data);
        this.is_send_sms = true;
        let interval_time = 60;
        let timer = setInterval(() => {
          if (interval_time < 1) {
            // 停止倒计时，允许用户发送短信
            clearInterval(timer);
            this.is_send_sms = false; // 重新设置发送短信的间隔状态为false，允许再次发送短信
            this.sms_text = "انىقتاۋ كودىن جىبەر ";
          } else {
            interval_time--;
            this.sms_text = `${interval_time}سەكۋندتان كەيىن جولداۋعا بولادى `
          }
        }, 1000);
      }).catch(error => {
        this.$message.error(error.response.data.message)
      });
    }
  },
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

.box .register {
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

.register .register-title {
  width: 100%;
  font-size: 24px;
  text-align: center;
  padding-top: 30px;
  padding-bottom: 30px;
  color: #4a4a4a;
  letter-spacing: 0.39px;
}

.register-title img {
  width: 190px;
  height: auto;
}

.register-title p {
  font-family: PingFangSC-Regular;
  font-size: 18px;
  color: #fff;
  letter-spacing: 0.29px;
  padding-top: 10px;
  padding-bottom: 50px;
}

.register_box {
  width: 400px;
  height: auto;
  background: #fff;
  box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.5);
  border-radius: 4px;
  margin: 0 auto;
  padding-bottom: 40px;
}

.register_box .title {
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

.register_box .title span:nth-of-type(1) {
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
  width: 30px;
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

.register_btn {
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
