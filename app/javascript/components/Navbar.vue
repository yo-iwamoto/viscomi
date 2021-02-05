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
        <v-list dense nav>
          <template v-if="userData.is_manager">

            <v-list-item :to="{ path: 'center', query: { cid: followingId } }">
              <v-list-item-icon>
                <v-icon>mdi-home-variant</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>管理者ページ</v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-list-item v-bind="{ to: '/new_post' }" link>
              <v-list-item-icon>
                <v-icon>mdi-pencil</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>投稿を作成</v-list-item-title>
              </v-list-item-content>
            </v-list-item>

            <v-list-item v-bind="{ to: '/new_ad' }" link>
              <v-list-item-icon>
                <v-icon>mdi-clipboard-plus</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>広告を作成</v-list-item-title>
              </v-list-item-content>
            </v-list-item>

          </template>
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
          <LogOut v-if="loggedIn" />
        </v-list>
        <v-img src="/images/ad.jpg" class="nav-ad"></v-img>
      </div>
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
import { mapGetters } from 'vuex'

export default {
  data: () => ({
    drawer: false,
    // リストレンダリングでto, iconもバインド、idTokenはサインイン/アウトに応じた切り替えに必要
    drawerItems: [
      {
        name: 'トップページ',
        icon: 'mdi-home',
        to: '/',
        hideWhenLogin: false
      },
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
        icon: 'mdi-tooltip-account',
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
  },
  methods: {
    toTop () {
      this.$router.push('/')
    }
  }
}
</script>
