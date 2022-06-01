<template>
  <div class="player">
    <h1>播放</h1>
    <div id="player"></div>
  </div>
</template>

<script>
export default {
  name: "Player",
  data() {
    return {}
  },
  methods: {
    check_login() {
      // 检查当前访问者是否登录了！
      let token = localStorage.user_token || sessionStorage.user_token;
      if (!token) {
        this.$alert("对不起，您尚未登录，请登录以后再进行学习。").then(() => {
          this.$router.push("/user/login");
        });
        return false; // 阻止代码往下执行
      }
      return token;
    },
  },
  // created 初始化，放置的是ajax等操作/获取数据的代码，不涉及操作页面
  // mounted 初始化，放置的是关于操作页面的初始化js代码
  mounted() {
    let jwt_token = this.check_login();
    let user_name = localStorage.user_name || sessionStorage.user_name;
    // 1. 到数据库中查询用户购买的课程是否有当前章节
    // 2. 到数据库中查询用户购买的课程是否有在有效期内
    let vid = "123d56b2b5ff2a46cc7b856070cddf26_1"; // this.$router.query.vid;
    console.log(vid)
    let self = this;

    var player = polyvPlayer({
      wrap: '#player',
      width: document.documentElement.clientWidth - 260, // 页面宽度
      height: document.documentElement.clientHeight, // 页面高度
      forceH5: true,
      vid: vid,
      code: user_name, // 一般是用户昵称
      // 视频加密播放的配置
      playsafe: function (vid, next) { // 向后端发送请求获取加密的token
        self.$axios.get(`${self.$settings.HOST}/course/player/`, {
          params: {
            vid: vid,
          },
          headers: {
            "Authorization": "jwt " + jwt_token,
          }
        }).then(function (response) {
          // 获取播放视频的token令牌(播放加密视频时会调用)
          next(response.data);
        })
      }
    });
  },
  computed: {}
}
</script>

<style scoped>

</style>
