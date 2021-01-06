<template>
  <v-app>
    <v-navigation-drawer app v-model="drawer" class="pa-2">
      <v-list-item>
        <img src="images/icon.png" class="app-img" @click="dammy">
      </v-list-item>
      <v-list-item>
        <!-- サインイン/アウトで切り替え -->
        <v-list-item-content v-if="isAuthenticated">
          <v-list-item-title class="title">Sample User</v-list-item-title>
          <v-list-item-subtitle>xxxxx@yyy.com</v-list-item-subtitle>
        </v-list-item-content>
        <v-list-item-content v-else>
          <v-list-item-title class="title">ビズコミへようこそ！</v-list-item-title>
          <v-list-item-subtitle>まずはサインアップ</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-list dense nav>
        <!-- to属性を指定することでrouter-linkとして機能 -->
        <v-list-item
          v-for="item in drawerItemsFiltered"
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
        <v-list-item v-if="isAuthenticated" @click="dammy">
          <v-list-item-icon>
            <v-icon>mdi-login-variant</v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title>サインアウト</v-list-item-title>
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
    <!-- router-view全体にtext-align: centerとmargin: 0 autoをあてる -->
    <v-main class="app-container text-center">
      <transition name="fade" mode="out-in">
        <router-view/>
      </transition>
    </v-main>
  </v-app>
</template>

<script>
export default {
  data: () => ({
    drawer: false,
    users: [],
    // リストレンダリングでto, iconもバインド、idTokenはサインイン/アウトに応じた切り替えに必要
    drawerItems: [
      {
        name: 'サインアップ',
        icon: 'mdi-account-plus-outline',
        to: '/signup',
        idToken: false
      },
      {
        name: 'サインイン',
        icon: 'mdi-login-variant',
        to: '/signin',
        idToken: false
      },
      {
        name: 'ダッシュボード',
        icon: 'mdi-dock-top',
        to: '/dashboad',
        idToken: true
      }
    ]
  }),
  methods: {
    dammy () {
      this.drawer = this.drawer
    }
  },
  computed: {
    isAuthenticated () {
      true
    },
    drawerItemsFiltered () {
      true
    }
  }
}
</script>
