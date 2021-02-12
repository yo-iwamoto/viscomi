<template>
  <v-app>
    <Navbar/>
    <!-- router-view全体にtext-align: centerとmargin: 0 autoをあてる -->
    <v-main class="app-container text-center">
      <Loading v-if="isLoading" />
      <transition name="fade" mode="out-in">
        <router-view />
      </transition>
    </v-main>
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: mapGetters(['isLoading']),
  // updated () {
  //   window.addEventListener('popstate', () => {
  //     location.reload()
  //   })
  // }
}
</script>