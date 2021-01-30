<template>
  <div class="ma-10">
    <h1 id="form-title">ログイン</h1>
    <p>ボタンをクリックすると、自動でサンプルのログイン情報が入力されます。</p>
    <div class="login-auto-fill">
      <button @click="comUser">公民館ユーザー</button>
      <button @click="genUser">一般ユーザー</button>
    </div>
    <v-form class="form">
      <v-text-field
        v-model="form.email"
        label="メールアドレス"
        required
      ></v-text-field>
      <!-- append-icon属性は横の表示アイコン
      表示のアイコンをクリック時表示／非表示アイコンが切り替わり、
      同時にtypeがpassword, textと切り替わることで、
      非表示アイコン時、入力文字を伏せ字にする-->
      <v-text-field
        v-model="form.password"
        :type="appendIcon ? 'text' : 'password'"
        label="パスワード"
        :append-icon="appendIcon ? 'mdi-eye' : 'mdi-eye-off'"
        required
        @click:append="appendIcon = !appendIcon"
      ></v-text-field>
      <span
        class="blue--text text--lighten-2 signin-span to-password-reset"
        @click="toPasswordReset"
      >パスワードを忘れた場合</span>
      <!-- formタグのsubmitを使うと自動で画面がリフレッシュされ、不都合なため、clickイベントで処理 -->
      <input type="button" value="ログイン" class="colored white--text py-2 px-5 rounded" @click="logIn(form)">
    </v-form>
    <p class="ma-5">初めてのご利用ですか？ <br><span @click="toSignUp" class="blue--text text--lighten-2 signin-span">利用者登録</span></p>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  data: () => ({
    form: {
      email: '',
      password: ''
    },
    password: 'foobar',
    appendIcon: false
  }),
  computed: mapGetters(["loggedIn"]),
  mounted () {
    if (this.loggedIn) {
      this.$router.push('/mypage')
    }
  },
  methods: {
    ...mapActions(["logIn"]),
    toSignUp () {
      this.$router.push('/signup')
    },
    toPasswordReset () {
      this.$router.push('/reset')
    },
    comUser () {
      this.form = {
        email: 'tenjinyama@example.com',
        password: this.password
      }
    },
    genUser () {
      this.form = {
        email: 'user1@example.com',
        password: this.password
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.login-auto-fill {
  button {
    border: 1px solid skyblue;
    border-radius: 10px;
    padding: 5px;
    background-color: skyblue;
    color: white;
  }
}
</style>