import Vue from 'vue'
import Router from 'vue-router'

import Top from './views/Top'
import SignUp from './views/SignUp'
import SignIn from './views/SignIn'

// コンポーネント、ストアのインポート
import store from './plugins/store'

Vue.use(Router)

function title (title) {
  `${title} | VISCOMI`
}

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'top',
      component: Top,
      meta: {
        title: 'ビズコミ',
        desc: '公民館の情報発信を前進させるサービス'
      }
    },
    {
      path: '/signup',
      name: 'signup',
      component: SignUp,
      meta: {
        title: title('ユーザー登録')
      }
    },
    {
      path: '/signin',
      name: 'signin',
      component: SignIn,
      meta: {
        title: title('ログイン')
      }
    }
  ]
})