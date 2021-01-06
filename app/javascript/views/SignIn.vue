<template>
  <div class="ma-10">
    <h1>サインイン</h1>
    <v-form class="form">
      <v-text-field
        v-model="email"
        label="メールアドレス"
        required
      ></v-text-field>
      <!-- append-icon属性は横の表示アイコン
      表示のアイコンをクリック時表示／非表示アイコンが切り替わり、
      同時にtypeがpassword, textと切り替わることで、
      非表示アイコン時、入力文字を伏せ字にする-->
      <v-text-field
        v-model="password"
        :type="appendIcon ? 'text' : 'password'"
        label="パスワード"
        :append-icon="appendIcon ? 'mdi-eye' : 'mdi-eye-off'"
        required
        @click:append="appendIcon = !appendIcon"
      ></v-text-field>
      <!-- formタグのsubmitを使うと自動で画面がリフレッシュされ、不都合なため、clickイベントで処理 -->
      <input type="button" value="サインイン" class="green lighten-1 white--text py-2 px-5 rounded" @click="onSubmit">
    </v-form>
    <p class="ma-5">アカウントを持っていませんか？ <br><span @click="toSignUp" class="blue--text text--lighten-2 signin-span">サインアップ</span></p>
  </div>
</template>

<script>
export default {
  data: () => ({
    email: '',
    password: '',
    appendIcon: false
  }),
  methods: {
    onSubmit () {
      // store.jsのsignInアクションを参照
      this.$store.dispatch('signIn', {
        email: this.email,
        password: this.password
      })
      this.$router.push('/dashboad')
    },
    toSignUp () {
      this.$router.push('/signup')
    }
  }
}
</script>
