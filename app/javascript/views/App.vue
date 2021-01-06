<template>
  <v-app>
    <Navbar/>
    <router-link to="/login">ログイン</router-link>
    <!-- router-view全体にtext-align: centerとmargin: 0 autoをあてる -->
    <v-main class="app-container text-center">
      <transition name="fade" mode="out-in">
        <router-view></router-view>
      </transition>
    </v-main>
  </v-app>
</template>

<script>
import Navbar from '../components/Navbar'

export default {
  components: {
    Navbar
  }
}
</script>