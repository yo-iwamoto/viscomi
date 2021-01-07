<template>
  <div class="ma-10">
    <h1 id="form-title">ログイン</h1>
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
      <input type="button" value="ログイン" class="green lighten-1 white--text py-2 px-5 rounded" @click="onSubmit">
    </v-form>
    <p class="ma-5">初めてのご利用ですか？ <br><span @click="toSignUp" class="blue--text text--lighten-2 signin-span">利用者登録</span></p>
  </div>
</template>

<script>
export default {
  data: () => ({
    form: {
      email: '',
      password: ''
    },
    appendIcon: false
  }),
  methods: {
    toSignUp () {
      this.$router.push('/signup')
    },
    onSubmit () {
      this.$store.dispatch('logIn', this.form)
    },
    toPasswordReset () {
      this.$router.push('/reset')
    }
  }
}
</script>
