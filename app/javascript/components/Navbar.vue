<template>
  <nav>
    <v-navigation-drawer app v-model="drawer" class="pa-2">
      <v-list-item class="mt-5">
        <img src="images/logo" class="app-img" @click="toTop">
      </v-list-item>
      <v-list-item>
        <!-- サインイン/アウトで切り替え -->
        <v-list-item-content v-if="loggedIn">
          <v-list-item-title class="title">{{ userData.name }}</v-list-item-title>
          <v-list-item-subtitle>{{ userData.email }}</v-list-item-subtitle>
        </v-list-item-content>
        <v-list-item-content v-else>
          <v-list-item-title class="title">ビズコミへようこそ！</v-list-item-title>
          <v-list-item-subtitle>まずはサインアップ</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-list dense nav>
        <!-- to属性を指定することでrouter-linkとして機能 -->
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
          <v-list-item v-bind="{ to: `/center/${comId}` }" link>
            <v-list-item-icon>
              <v-icon>mdi-home-variant</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>管理者ページ</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>
        <LogOut v-if="loggedIn" />
      </v-list>
    </v-navigation-drawer>
    <v-app-bar app class="cyan darken-2">
      <!-- navigation-drawerの表示／非表示 -->
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <router-link to="/">
        <v-toolbar-title class="white--text link">VISCOMI</v-toolbar-title>
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
        idToken: false,
        hideWhenLogIn: true
      },
      {
        name: 'ログイン',
        icon: 'mdi-login-variant',
        to: '/login',
        idToken: false,
        hideWhenLogIn: true
      },
      {
        name: 'マイページ',
        icon: 'mdi-application',
        to: '/mypage',
        idToken: true,
        hideWhenLogIn: false
      }
    ]
  }),
  computed: mapGetters(["userData", "comId", "loggedIn"]),
  methods: {
    toTop () {
      this.$router.push('/')
    }
  }
}
</script>
