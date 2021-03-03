<template>
  <v-app>
    <the-navbar/>
    <!-- router-view全体にtext-align: centerとmargin: 0 autoをあてる -->
    <v-main class="app-container text-center">
      <loading-circle v-if="isLoading" />
      <transition name="fade" mode="out-in">
        <router-view />
      </transition>
    </v-main>
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: mapGetters(['isLoading'])
}
</script>