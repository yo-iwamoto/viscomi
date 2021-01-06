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
import axios from '../plugins/api/axios'
export default {
  data: () => ({
    user: {}
  }),
  created () {
    if (this.$store.getters.userId !== "undefined") {
      axios.get(`/users/${this.$store.getters.userId}`).then(res => {
        this.user = res.data
      })
    } else {
      this.$router.push('/login')
    }
  },
  computed: {
    userId () {
      return this.$store.getters.userId
    }
  }
}
</script>