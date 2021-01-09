<template>
  <v-list-item class="list-item" @click="onClick">
    <v-list-item-icon>
      <v-icon>mdi-logout-variant</v-icon>
    </v-list-item-icon>
    <v-list-item-content>
      <v-list-item-title>ログアウト</v-list-item-title>
    </v-list-item-content>
  </v-list-item>
</template>

<script>
import { mapActions } from 'vuex'

export default {
  methods: {
    ...mapActions(["logOut"]),
    onClick () {
      this.logOut()
      this.$router.push('/')
    }
  }
}
</script>