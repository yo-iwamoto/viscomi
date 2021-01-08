<template>
  <div id="mypage-cotainer">
    <div class="to-com" v-show="user.is_manager">
      <Link v-bind="{ path: `/com/${comId}` }" icon="mdi-home-variant" name="管理者ページへ" />
    </div>
    <div class="to-edit" @click="toEdit">
      <v-icon large>mdi-account-cog</v-icon>
    </div>
    <h1>マイページ</h1>
    <v-divider class="hr mt-10 mb-10"></v-divider>
    <div class="user-info">
      <div class="no-img"></div>
      <h3>名前：{{ user.name }}</h3>
      <h3>メールアドレス：{{ user.email }}</h3>
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
    comId () {
      var comData = this.$store.getters.communityCenterData
      if (!comData) {
        return null
      } else {
        return comData.community_center_id
      }
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
  methods: {
    toEdit () {
      this.$router.push('/edit-mypage')
    }
  },
  components: {
    Link
  }
}
</script>