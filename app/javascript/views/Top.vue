<template>
  <div id="top-wrapper">
    <template v-if="!loggedIn">
      <Modal v-bind="{
        title: '登録手続き',
        message: 'ご記入のメールアドレスに本人確認用のメールを送信致しました。メールに記載のURLより確認をお願い致します。',
        dialog: signedUp
      }"/>
      <div class="logo-container">
        <img src="images/logo.png" alt="VISCOMI" class="top-logo">
      </div>
      <h2 id="main-copy" class="font-maru">ビズコミは、公民館と地域の交流を
        <br>より便利にするウェブサイトです</h2>
      <v-divider class="mt-5"></v-divider>
      <div class="top-menu">
        <div class="to-signup">
          <p>初めて利用される方は</p>
          <Link path="/signup" name="利用者登録" />
        </div>
        <div class="to-login">
          <p>既にご登録がお済みの方は</p>
          <Link path="/login" name="ログイン" />
        </div>
      </div>
    </template>

    
    <template v-else>
      <h2 class="font-maru">{{ pageData.name }}</h2>
      <TimeLine />
    </template>

    <!-- 管理者専用 -->

    <template v-if="userData.email == 'viscomi10440@gmail.com'">
      <Link path="/new_ad" name="広告を作成" icon="mdi-clipboard-plus" />
    </template>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data: () => ({
    pageData: {
      name: null
    }
  }),
  computed: mapGetters(["signedUp", "userData", "loggedIn"]),
  mounted () {
    if (this.loggedIn) {
      this.$axios.get('/community_center').then(res => {
        this.pageData = res.data
      })
    }
  }
}
</script>