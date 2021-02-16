<template>
  <nav>
    <v-navigation-drawer app v-model="drawer" class="pa-2">
      <v-list-item class="mt-5">
        <img src="/images/logo.png" class="app-img mx-auto" @click="toTop">
      </v-list-item>
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
          <template v-if="userData.is_manager">
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
        <a href="https://www.notion.so/shuhei1040/J-PLANZ-d5add41b698e45ac8c207c1c94a68d2e" class="company-link" target="_blank">
          運営会社について
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
import { mapGetters } from 'vuex'

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
        name: 'フィードバック',
        icon: 'mdi-comment-multiple-outline',
        to: '/feedback',
        hideWhenLogin: false
      }
    ]
  }),
  computed: {
    ...mapGetters(['userData', 'userId', 'loggedIn', 'followingId']),
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
        {
          name: '広告を作成（仮設）',
          to: '/new_ad',
          icon: 'mdi-clipboard-plus-outline'
        }
      ]
    },
    route () {
      return this.$route
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
    toTop () {
      this.$router.push('/')
    },
    reload () {
      location.reload()
    },
    getNotifications () {
      if (this.loggedIn && !this.userId) {
        setTimeout(this.getNotifications, 1000)
      }
      this.$axios.get(`/notifications/${this.userId}`).then(res => {
        this.notifications = res.data
        this.notification = 0
        for (let i = 0; i < this.notifications.length; i ++) {
          if (!this.notifications[i].read) {
            this.notification ++
          }
        }
      })
    },
    read () {
      this.notification = 0
      this.$axios.patch(`/notifications/${this.userId}`).then(() => {
        this.getNotifications()
      })
    },
    help () {
      open('https://www.notion.so/shuhei1040/99ef299134104089ac7aa1a209c7aa89', '_blank')
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
}
</style>