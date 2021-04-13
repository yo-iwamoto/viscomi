<template>
  <nav v-if="!guide">
    <v-navigation-drawer app v-model="drawer" class="pa-2">
      <v-list-item class="my-5" v-if="!isManager">
        <img src="/images/logo.png" class="app-img mx-auto" @click="toTop">
      </v-list-item>
      <v-list-item class="mb-5" v-if="isManager"/>
      <v-list-item>
        <!-- サインイン時 -->
        <v-list-item-content v-if="loggedIn">
          <v-list-item-title class="title">{{ userData.name }}</v-list-item-title>
          <v-list-item-subtitle>{{ userData.email }}</v-list-item-subtitle>
        </v-list-item-content>
        <!-- サインアウト時 -->
        <v-list-item-content v-else>
          <v-list-item-title class="title">ビズコミへようこそ！</v-list-item-title>
          <v-list-item-subtitle>まずはサインアップ</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <div class="nav-flex">
        <v-list class="mb-10" dense nav>
          <v-list-item to="/new_ad" link v-if="userData.email == 'viscomi1040@gmail.com'">
            <v-list-item-icon><v-icon>mdi-clipboard-plus-outline</v-icon></v-list-item-icon>
            <v-list-item-content><v-list-item-title>広告を作成</v-list-item-title></v-list-item-content>
          </v-list-item>
          <v-list-item
            v-for="item in drawerItems"
            :key="item.name"
            :to="item.to"
            link
            v-show="(!item.hideWhenLogIn && loggedIn) || (item.hideWhenLogIn && !loggedIn)">
            <v-list-item-icon><v-icon>{{ item.icon }}</v-icon></v-list-item-icon>
            <v-list-item-content><v-list-item-title>{{ item.name }}</v-list-item-title></v-list-item-content>
          </v-list-item>
          <v-list-item @click="help">
            <v-list-item-icon><v-icon>mdi-help-circle-outline</v-icon></v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>ヘルプ　<v-icon color="#999" small>mdi-open-in-new</v-icon></v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <LogOut v-if="loggedIn" />
          <template v-if="isManager">
            <p class="font-maru grey--text mt-5">管理者メニュー</p>
            <v-list-item
              v-for="item in managerItems"
              :key="item.name"
              :to="item.to"
              link>
              <v-list-item-icon><v-icon>{{ item.icon }}</v-icon></v-list-item-icon>
              <v-list-item-content><v-list-item-title>{{ item.name }}</v-list-item-title></v-list-item-content>
            </v-list-item>
          </template>
        </v-list>
        <a href="https://j-planz.com/" class="company-link mb-5" target="_blank">
          会社概要
          <v-icon color="#999" small>mdi-open-in-new</v-icon>
        </a>
        <a href="https://viscomi.herokuapp.com/feedback" class="company-link">
          フィードバック
          <v-icon color="#999" small>mdi-open-in-new</v-icon>
        </a>
      </div>
    </v-navigation-drawer>

    <v-app-bar app class="" color="#243743">
      <v-app-bar-nav-icon @click="drawer = !drawer" color="white"></v-app-bar-nav-icon>
      <router-link to="/">
        <v-toolbar-title class="white--text link title" style="font-family: 'Montserrat">VISCOMI</v-toolbar-title>
      </router-link>
      <div class="header-icons ml-auto" width="100">
        <v-menu offset-y v-if="loggedIn">
          <template v-slot:activator="{ on, attrs }">
            <span
              @click="read"
              v-on="on"
              v-bind="attrs">
              <v-badge
                :value="notification"
                :content="notification"
                color="red"
                overlap>
                <v-icon color="white">mdi-bell</v-icon>
              </v-badge>
            </span>
          </template>
          <v-list min-width="300" v-if="notifications.length">
            <v-virtual-scroll
              :items="notifications"
              :item-height="90"
              height="250">
              <template v-slot:default="{ item }">
                <v-list-item>
                  <v-list-item-avatar><img src="images/apple-touch-icon.png" alt=""></v-list-item-avatar>
                  <v-list-item-content>
                    <v-list-item-title>{{ item.title }}</v-list-item-title>
                    <p class="grey--text">{{ item.content }}</p>
                  </v-list-item-content>
                </v-list-item>
              </template>
            </v-virtual-scroll>
          </v-list>
          <v-list v-else>
            <v-list-item>通知はありません</v-list-item>
          </v-list>
        </v-menu>
        <span @click="reload">
          <v-icon color="white">mdi-autorenew</v-icon>
        </span>
      </div>
    </v-app-bar>
  </nav>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'

export default {
  data: () => ({
    drawer: false,
    notification: 0,
    notifications: [],
    // リストレンダリングでto, iconもバインド、idTokenはサインイン/アウトに応じた切り替えに必要
    drawerItems: [
      {
        name: '利用者登録',
        icon: 'mdi-account-plus-outline',
        to: '/signup',
        hideWhenLogIn: true
      },
      {
        name: 'ログイン',
        icon: 'mdi-login-variant',
        to: '/login',
        hideWhenLogIn: true
      },
      {
        name: 'ホーム',
        icon: 'mdi-home-outline',
        to: '/',
        hideWhenLogin: false
      },
      {
        name: '設定',
        icon: 'mdi-wrench-outline',
        to: '/mypage',
        hideWhenLogIn: false
      },
      {
        name: '目安箱',
        icon: 'mdi-comment-multiple-outline',
        to: '/redirect',
        hideWhenLogin: false
      }
    ]
  }),
  computed: {
    ...mapGetters(['userData', 'userId', 'loggedIn', 'followingId', 'isManager']),
    managerItems () {
      return [
        {
          name: '管理者ページ',
          to: `/center?cid=${this.followingId}`,
          icon: 'mdi-shield-account'
        },
        {
          name: '投稿を作成',
          to: '/new_post',
          icon: 'mdi-pencil-outline'
        },
        {
          name: 'メール管理',
          to: '/contacts/index',
          icon: 'mdi-email-outline'
        },
        // {
        //   name: '広告を作成（仮設）',
        //   to: '/new_ad',
        //   icon: 'mdi-clipboard-plus-outline'
        // }
      ]
    },
    route () {
      return this.$route
    },
    guide () {
      return this.route.path === "/guide"
    }
  },
  watch: {
    route () {
      this.getNotifications()
    }
  },
  mounted () {
    this.getNotifications()
  },
  methods: {
    ...mapMutations(['updateIsLoading']),
    toTop () {
      this.$router.push('/')
    },
    reload () {
      this.updateIsLoading(true)
      location.reload()
    },
    getNotifications () {
      // 読み込み時のオートログインが非同期のため，終了する前にこちらのifが走る
      // そのため，まだuserIdが入っていないことがあるが，loggedInはHTTPリクエストを送る前にtrueに更新しているため，
      // このifにかかればuserIdが入るまで待ってnotificationを取得してくることができる
      if (this.loggedIn && !this.userId) {
        setTimeout(this.getNotifications, 1000)
      } else if (this.loggedIn) {
        this.$axios.get(`/notifications/${this.userId}`).then(res => {
          this.notifications = res.data
          // 通知件数をカウント
          this.notification = 0
          for (let i = 0; i < this.notifications.length; i ++) {
            if (!this.notifications[i].read) {
              this.notification ++
            }
          }
        })
      }
    },
    read () {
      this.notification = 0
      this.$axios.patch(`/notifications/${this.userId}`).then(() => {
        setTimeout(this.getFollowers, 1000)
      })
    },
    help () {
      open('https://j-planz.com/99ef299134104089ac7aa1a209c7aa89', '_blank')
    },
    opinion () {
      open('https://forms.gle/oQorFcWkQWwxrNrAA', '_blank')
    }
  }
}
</script>

<style lang="scss" scoped>
.title {
  font-weight: bold;
}
.header-icons {
  span {
    cursor: pointer;
    padding: 0 7px;
  }
}

.company-link {
  font-size: 14px;
  margin-left: 10px;
  border-bottom: 1px solid black;
  color: #555;
  white-space: nowrap;
}

.opinion {
  color: #777;
}
</style>