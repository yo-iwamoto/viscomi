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
      </div>
    </v-navigation-drawer>

    <v-app-bar app class="" color="#243743">
      <v-app-bar-nav-icon @click="drawer = !drawer" color="white"></v-app-bar-nav-icon>
      <router-link to="/">
        <v-toolbar-title class="white--text link title" style="font-family: 'Montserrat">VISCOMI</v-toolbar-title>
      </router-link>
      <div class="header-icons ml-auto" width="100">
        <span @click="reload">
          <v-icon color="white">mdi-bell</v-icon>
        </span>
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
      },
      {
        name: 'ヘルプ',
        icon: 'mdi-help-circle-outline',
        hideWhenLogin: false
      }
    ]
  }),
  computed: {
    ...mapGetters(["userData", "loggedIn", "followingId"]),
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
    }
  },
  methods: {
    toTop () {
      this.$router.push('/')
    },
    reload () {
      location.reload()
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
</style>