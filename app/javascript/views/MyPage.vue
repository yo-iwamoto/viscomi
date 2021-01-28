<template>
  <div id="mypage-container">
    <div class="to-com" v-show="userData.is_manager">
      <Link v-bind="{ path: `/center/${followingId}` }" icon="mdi-home-variant" name="管理者ページへ" />
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
      <h3>登録している公民館：{{ userData.following.name }}</h3>
    </div>
    <Link path="/new_ad" name="広告を作成" icon="mdi-clipboard-plus" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Link from '../components/Link'

export default {
  components: {
    Link
  },
  computed: mapGetters(['userData', 'followingId', 'loggedIn']),
  mounted () {
    if (!this.loggedIn) {
      this.$router.push('/login')
    }
  },
  methods: {
    toEdit () {
      this.$router.push('/edit_mypage')
    }
  }
}
</script>