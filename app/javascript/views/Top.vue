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
      <h2 id="main-copy">ビズコミは、公民館と地域の交流を
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
      <h2>{{ pageData.name }}</h2>
      <p class="pt-5">~お知らせ~</p>
      <TimeLine />
    </template>
  </div>
</template>

<script>
import axios from '../plugins/api/axios'
import Modal from '../components/Modal'
import Link from '../components/Link'
import TimeLine from '../components/TimeLine'
import { mapGetters } from 'vuex'

export default {
  components: {
    Link,
    Modal,
    TimeLine
  },
  data: () => ({
    pageData: {
      name: null
    }
  }),
  computed: mapGetters(["signedUp", "loggedIn", "comData", "userFollowingId"]),
  mounted () {
    axios.get(`/community_centers/${this.userFollowingId}`).then(res => {
      this.pageData = res.data
    })
  }
}
</script>