import Vue from 'vue'
import Router from 'vue-router'

// コンポーネントのインポート
import Top from './views/Top'
import SignUp from './views/SignUp'
import LogIn from './views/LogIn'
import MyPage from './views/MyPage'
import Edit from './views/Edit'
import NotFound from './views/404'
import NewManager from './views/NewManager'
import CommunityCenter from './views/CommunityCenter'
import NewPost from './views/NewPost'

import Post from './components/Post'

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
      name: '利用者登録',
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
    },
    {
      path: '/edit-mypage',
      name: '設定',
      component: Edit
    },
    {
      path: '/new_manager',
      name: '管理者登録',
      component: NewManager
    },
    {
      path: '/com/:id',
      component: CommunityCenter
    },
    {
      path: '/new-post',
      name: 'ポスト作成',
      component: NewPost
    },
    {
      path: '/post',
      component: Post
    },
    {
      path: '*',
      name: "不明なページ",
      component: NotFound
    }
  ]
})

router.beforeEach((to, from, next) => {
  setTitle(to.name)
  next(next.path)
})

export default router