<template>
  <v-app>
    <the-navbar/>
    <v-main class="app-container text-center">
      <loading-circle />
      <transition name="fade" mode="out-in">
        <router-view />
      </transition>
    </v-main>
  </v-app>
</template>