import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Login from "@/components/Login";
import Register from "@/components/Register";
import Validmail from '@/components/Validmail';
import Repassword from '@/components/Repassword';
import Course from '@/components/Course';
import Detail from '@/components/Detail';
import Cart from '@/components/Cart';
import Order from '@/components/Order';
import Success from "@/components/Success";
import UserOrder from "@/components/UserOrder";
import Player from "@/components/Player";
import Play from "@/components/Play";
import Study from "@/components/Study";
import OnlineCourse from "@/components/OnlineCourse";

Vue.use(Router)

export default new Router({
  mode: "history",
  routes: [
    {
      path: '/',
      redirect: Home
    },
    {
      path: '/home',
      name: 'Home',
      component: Home
    },
    {
      path: '/user/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/user/reg',
      name: 'Register',
      component: Register
    },
    {
      path: '/user/validmail',
      name: 'Validmail',
      component: Validmail
    },
    {
      path: '/course',
      name: 'Course',
      component: Course
    },
    {
      path: '/course/detail/:id',
      name: 'Detail',
      component: Detail
    },
    {
      path: '/cart',
      name: 'Cart',
      component: Cart
    },
    {
      path: '/order',
      name: 'Order',
      component: Order
    },
    {
      path: '/payments/alipay/result',
      name: 'Success',
      component: Success
    },
    {
      path: '/user/order',
      name: 'UserOrder',
      component: UserOrder
    },
    {
      path: '/course/player',
      name: 'Player',
      component: Player
    },
    {
      path: '/study',
      name: 'Study',
      component: Study
    },
    {
      path: '/course/play',
      name: 'Play',
      component: Play
    },
    {
      path: '/online',
      name: 'OnlineCourse',
      component: OnlineCourse
    }

  ]
})
