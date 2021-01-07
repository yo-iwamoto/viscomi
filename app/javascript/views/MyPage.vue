<template>
  <div>
    <h1>マイページ</h1>
    <v-divider class="hr mt-10 mb-10"></v-divider>
    <div class="user-info">
      <h2>ニックネーム：{{ user.name }}</h2>
      <h2>メールアドレス：{{ user.email }}</h2>
    </div>
  </div>
</template>

<script>
export default {
  data: () => ({
  }),
  computed: {
    user () {
      return this.$store.getters.userData
    },
    logged_in () {
      return !this.$store.getters.userId
    }
  }
}
</script>