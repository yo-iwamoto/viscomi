<template>
  <div id="mypage-cotainer">
    <div class="to-com" v-show="user.is_manager">
      <Link v-bind="{ path: `/com/${comData.community_center_id}` }" name="管理者ページへ" />
    </div>
    <h1>マイページ</h1>
    <v-divider class="hr mt-10 mb-10"></v-divider>
    <div class="user-info">
      <h2>ニックネーム：{{ user.name }}</h2>
      <h2>メールアドレス：{{ user.email }}</h2>
    </div>
  </div>
</template>

<script>
import Link from '../components/Link'

export default {
  computed: {
    user () {
      return this.$store.getters.userData
    },
    comData () {
      return this.$store.getters.communityCenterData
    },
    logged_in () {
      return this.$store.getters.userId !== -1
    }
  },
  mounted () {
    if (!this.logged_in) {
      this.$router.push('/login')
    }
  },
  components: {
    Link
  }
}
</script>