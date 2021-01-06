<template>
  <nav>
    <v-navigation-drawer app v-model="drawer" class="pa-2">
      <v-list-item>
        <img src="images/icon.png" class="app-img" @click="toTop">
      </v-list-item>
      <v-list-item>
        <!-- サインイン/アウトで切り替え -->
        <v-list-item-content>
          <v-list-item-title class="title">Sample User</v-list-item-title>
          <v-list-item-subtitle>xxxxx@yyy.com</v-list-item-subtitle>
        </v-list-item-content>
        <!-- <v-list-item-content>
          <v-list-item-title class="title">ビズコミへようこそ！</v-list-item-title>
          <v-list-item-subtitle>まずはサインアップ</v-list-item-subtitle>
        </v-list-item-content> -->
      </v-list-item>
      <v-list dense nav>
        <!-- to属性を指定することでrouter-linkとして機能 -->
        <v-list-item
          v-for="item in drawerItems"
          :key="item.name"
          :to="item.to"
          link
        >
          <v-list-item-icon>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>{{ item.name }}</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
        <!-- サインアウトのみv-forから外れているのは、ひとつだけv-on:clickを設定するためです -->
        <v-list-item @click="dammy">
          <v-list-item-icon>
            <v-icon>mdi-logout-variant</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>ログアウト</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <v-app-bar app color="orange lighten-2">
      <!-- navigation-drawerの表示／非表示 -->
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <router-link to="/">
        <v-toolbar-title class="white--text link">VISCOMI</v-toolbar-title>
      </router-link>
    </v-app-bar>
  </nav>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
    users: [],
    // リストレンダリングでto, iconもバインド、idTokenはサインイン/アウトに応じた切り替えに必要
    drawerItems: [
      {
        name: '利用者登録',
        icon: 'mdi-account-plus-outline',
        to: '/signup',
        idToken: false
      },
      {
        name: 'ログイン',
        icon: 'mdi-login-variant',
        to: '/login',
        idToken: false
      },
      {
        name: 'マイページ',
        icon: 'mdi-application',
        to: '/mypage',
        idToken: true
      }
    ]
  }),
  methods: {
    toTop () {
      this.$router.replace('/')
    },
    dammy () {
      this.drawer = this.drawer
    }
  }
}
</script>
