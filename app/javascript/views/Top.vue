<template>
  <div id="top-wrapper">
    <Modal v-bind="{ title: title, message: message, dialog: fromSignUp }" />
    <h2 id="main-copy">ビズコミは、地域の公民館からのお知らせを
      <br>簡単に受け取ることができるウェブサイトです</h2>
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
  </div>
</template>

<script>
import Modal from '../components/Modal'
import Link from '../components/Link'
export default {
  components: {
    Link,
    Modal
  },
  data: () => ({
    title: '登録手続き',
    message: 'ご記入のメールアドレスに本人確認用のメールを送信致しました。メールに記載のURLより確認をお願い致します。'
  }),
  computed: {
    fromSignUp () {
      return this.$store.getters.fromSignUp
    }
  }
}
</script>