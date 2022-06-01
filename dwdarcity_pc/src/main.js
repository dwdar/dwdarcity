// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import settings from "./settings";

Vue.config.productionTip = false
Vue.prototype.$settings = settings;

// element-ui 配置
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

// 导入css初始化样式
import '../static/css/reset.css'

// 导入axios
import axios from "axios";
// 不允许ajax发送请求时附带cookie
axios.defaults.withCredentials = false;
Vue.prototype.$axios = axios;


// 加载 vue-player 视频播放器组件
import VideoPlayer from 'vue-video-player'
import 'vue-video-player/src/custom-theme.css'
import 'video.js/dist/video-js.css'

Vue.use(VideoPlayer);

// 导入和初始化vuex
import store from './store/index';

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: {
    App
  },
  template: '<App/>'
});
