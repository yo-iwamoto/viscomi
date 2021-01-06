import Vue from 'vue'
import Router from 'vue-router'

import Top from './views/Top'
import SignUp from './views/SignUp'
import LogIn from './views/LogIn'
import MyPage from './views/MyPage'

// コンポーネント、ストアのインポート
import store from './plugins/store'

import { setTitle } from './mixins/set_title'

Vue.use(Router)

const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Top,
      
    },
    {
      path: '/signup',
      name: 'ユーザー登録',
      component: SignUp
    },
    {
      path: '/login',
      name: 'ログイン',
      component: LogIn
    },
    {
      path: '/mypage',
      name: 'マイページ',
      component: MyPage
    }
  ]
})

router.beforeEach((to, from, next) => {
  setTitle(to.name)
  next(next.path)
})

export default router