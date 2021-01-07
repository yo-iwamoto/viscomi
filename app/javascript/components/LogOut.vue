<template>
  <v-list-item class="list-item" @click="logOut">
    <v-list-item-icon>
      <v-icon>mdi-logout-variant</v-icon>
    </v-list-item-icon>
    <v-list-item-content>
      <v-list-item-title>ログアウト</v-list-item-title>
    </v-list-item-content>
  </v-list-item>
</template>

<script>
export default {
  methods: {
    logOut () {
      this.$store.dispatch('logOut')
      this.$router.push('/')
    }
  }
}
</script>

<style scoped lang="scss">
.list-item {
  cursor: pointer;
}
</style>