<template>
  <div class="login box">
    <img src="../../static/image/Loginbg.3377d0c.jpg" alt="" />
    <div class="login">
      <div class="login-title">
        <img src="../../static/image/Logotitle.1ba5466.png" alt="" />
        <p>帮助有志向的年轻人通过努力学习获得体面的工作和生活!</p>
      </div>
      <div class="login_box">
        <div class="title">
          <span class="active" @click="getUserInfo">{{username}}重置密码</span>
        </div>
        <div class="inp">
          <input v-model="password" type="password"  placeholder="新密码" class="user" />
             <input v-model="repassword" type="password" @blur="checkrepassword"  placeholder="重新输入新密码" class="user" />
          <div id="geetest1"></div>

          <button class="login_btn" @click="rePasswordHandler">确认重置</button>
          <p class="go_login">
            没有账号 <router-link to="/user/reg">立即注册</router-link>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Repassword",
  data() {
    return {
      username: "",
      password: "",
      repassword: ""
    };
  },
  created() {
    this.getUserInfo();
  },
  methods: {
    getUserInfo(){
      this.username = sessionStorage.getItem('user_name');
    },
    checkrepassword() {
      // 前段教研两次输入的密码是否一直
      if (this.password != this.repassword) {
        this.password = "";
        this.repassword="";
        this.$message({
          message: "两次输入的密码不一致",
          typpe: "error"
        });
        return 
      }
    },
    rePasswordHandler(){
      // 重置密码
      // 1.准备用户信息
      let userInfo = {
        username:this.username,
        token:sessionStorage.getItem("user_token"),
        newpassword:this.password,
        renewpassword:this.repassword
      }
      // 2. 发送ajax请求
      this.$axios .post( `${this.$settings.HOST}/user/repassword/` , userInfo ).then(response=>{
        console.log(response.data);
        sessionStorage.removeItem("user_id");
        sessionStorage.removeItem("user_token");
        sessionStorage.removeItem("user_name");
        localStorage.removeItem("user_id");
        localStorage.removeItem("user_token");
        localStorage.removeItem("user_name");

      // 页面跳转
          let self = this;
          this.$alert("密码修改成功", "Dwdar学城", {
            callback() {
              self.$router.push("/user/login/");
            }
      })
      }).catch(error => {
             this.$message.error(error.response.data.message);
             this.$router.push("/user/validmail/");

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
  left: 0;
  margin: auto;
  right: 0;
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
  background: #fcfcfc;
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
  border-bottom: 2px solid #ff5722;
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
  margin-left: 22px;
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
  /*left: 20px;*/
}

#geetest {
  margin-top: 20px;
}

.login_btn {
  width: 100%;
  height: 45px;
  background: #ff5722;
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
  right: 16px;
  border-left: 1px solid #484848;
  padding-left: 16px;
  padding-bottom: 4px;
  cursor: pointer;
  background-color: #fff;
  overflow: hidden;
}
</style>
