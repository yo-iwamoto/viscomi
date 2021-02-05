import Vue    from 'vue'
import Router from 'vue-router'

// コンポーネントのインポート
import Top             from './views/Top'
import SignUp          from './views/SignUp'
import LogIn           from './views/LogIn'
import MyPage          from './views/MyPage'
import EditMyPage      from './views/EditMyPage'
import EditComPage     from './views/EditComPage'
import NotFound        from './views/404'
import NewManager      from './views/NewManager'
import CommunityCenter from './views/CommunityCenter'
import NewPost         from './views/NewPost'
import EditPost        from './views/EditPost'
import NewAd           from './views/NewAd'
import Contacts        from './views/Contacts/Contacts'
import ContactsIndex   from './views/Contacts/Index'
import NewContact      from './views/Contacts/New'
import EditContact     from './views/Contacts/Edit'

import Post from './components/Post'

import { setTitle } from './packs/set_title'

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
      path: '/edit_mypage',
      name: '設定',
      component: EditMyPage
    },
    {
      path: '/edit_com',
      name: '公民館情報編集',
      component: EditComPage
    },
    {
      path: '/new_manager',
      name: '管理者登録',
      component: NewManager
    },
    {
      path: '/center',
      component: CommunityCenter
    },
    {
      path: '/new_post',
      name: '投稿作成',
      component: NewPost
    },
    {
      path: '/edit_post',
      name: '投稿編集',
      component: EditPost
    },
    {
      path: '/post',
      component: Post
    },
    {
      path: '/new_ad',
      name: '広告作成',
      component: NewAd
    },
    {
      path: '/contacts',
      name: 'メール',
      component: Contacts,
      children: [
        {
          path: 'index',
          name: 'メール一覧',
          component: ContactsIndex
        },
        {
          path: 'new',
          name: 'メール作成',
          component: NewContact
        },
        {
          path: 'edit',
          name: 'メール編集',
          component: EditContact
        }
      ]
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