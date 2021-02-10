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
      <span class="reflesh" @click="reload">
        <v-icon color="white">mdi-autorenew</v-icon>
      </span>
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
        name: 'トップページ',
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
          to: { path: 'center', query: { cid: this.followingId } },
          icon: 'mdi-shield-account'
        },
        {
          name: '投稿を作成',
          to: '/new_post',
          icon: 'mdi-pencil-outline'
        },
        {
          name: '広告を作成（仮設）',
          to: '/new_ad',
          icon: 'mdi-clipboard-plus-outline'
        },
        {
          name: 'メール管理',
          to: '/contacts/index',
          icon: 'mdi-email-outline'
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
.reflesh {
  width: 20px;
  margin-left: auto;
  cursor: pointer;
}
</style>