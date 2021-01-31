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
      <v-list dense nav>
        <v-list-item
          v-for="item in drawerItems"
          :key="item.name"
          :to="item.to"
          link
          v-show="(!item.hideWhenLogIn && loggedIn) || (item.hideWhenLogIn && !loggedIn)"
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>{{ item.name }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <template v-if="userData.is_manager">
          <v-list-item v-bind="{ to: `/center/${followingId}` }" link>
            <v-list-item-icon>
              <v-icon>mdi-home-variant</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>管理者ページ</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>
        <template v-if="userData.is_manager">
          <v-list-item v-bind="{ to: '/new_ad' }" link>
            <v-list-item-icon>
              <v-icon>mdi-clipboard-plus</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>広告を作成</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>
        <LogOut v-if="loggedIn" />
      </v-list>
      <v-list height="20vh"></v-list>
      <v-img src="/images/ad.jpg" class="nav-ad"></v-img>
    </v-navigation-drawer>
    <v-app-bar app class="" color="#243743">
      <v-app-bar-nav-icon @click="drawer = !drawer" color="white"></v-app-bar-nav-icon>
      <router-link to="/">
        <v-toolbar-title class="white--text link" style="font-family: 'Montserrat classic">VISCOMI</v-toolbar-title>
      </router-link>
    </v-app-bar>
  </nav>
</template>

<script>
import LogOut from './LogOut'
import { mapGetters } from 'vuex'

export default {
  components: {
    LogOut
  },
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
        name: 'マイページ',
        icon: 'mdi-application',
        to: '/mypage',
        hideWhenLogIn: false
      },
      {
        name: 'フィードバック',
        icon: 'mdi-comment-multiple-outline',
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
    // path: `https://sample/example/${this.userFollowingId}`
  },
  methods: {
    toTop () {
      this.$router.push('/')
    }
  }
}
</script>
