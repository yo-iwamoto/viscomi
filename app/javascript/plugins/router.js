import Vue from 'vue'
import Router from 'vue-router'

import Top from '../views/Top'

// コンポーネント、ストアのインポート
import store from './store'

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
    }
  ]
})