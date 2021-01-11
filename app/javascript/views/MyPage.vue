<template>
  <div id="mypage-cotainer">
    <div class="to-com" v-show="userData.is_manager">
      <Link v-bind="{ path: `/center/${comId}` }" icon="mdi-home-variant" name="管理者ページへ" />
    </div>
    <div class="to-edit" @click="toEdit">
      <v-icon large>mdi-account-cog</v-icon>
    </div>
    <h1>マイページ</h1>
    <v-divider class="hr mt-10 mb-10"></v-divider>
    <div class="user-info">
      <div class="no-img"></div>
      <h3>名前：{{ userData.name }}</h3>
      <h3>メールアドレス：{{ userData.email }}</h3>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Link from '../components/Link'

export default {
  components: {
    Link
  },
  computed: mapGetters(["userData", "comId", "loggedIn"]),
  mounted () {
    if (!this.loggedIn) {
      this.$router.push('/login')
    }
  },
  methods: {
    toEdit () {
      this.$router.push('/edit-mypage')
    }
  }
}
</script>