<template>
  <div class="ma-10 signup-container">
    <v-tabs
    v-model="tab"
    class="tabs-container mb-10"
    >
      <v-tabs-slider color="primary lighten-2"></v-tabs-slider>
      <v-tab class="tab" @click="isManager=false">利用者の方</v-tab>
      <v-tab class="tab" @click="isManager=true">運営者の方</v-tab>
    </v-tabs>
    <h1>サインアップ</h1>
    <v-form v-model="valid" class="form">
      <v-text-field
        v-model="email"
        label="メールアドレス"
        :rules="emailRules"
        required
      ></v-text-field>
      <!-- append-icon属性は横の表示アイコン
      表示のアイコンをクリック時表示／非表示アイコンが切り替わり、
      同時にtypeがpassword, textと切り替わることで、
      非表示アイコン時、入力文字を伏せ字にする-->
      <v-text-field
        v-model="password"
        label="パスワード"
        :append-icon="appendIcon ? 'mdi-eye' : 'mdi-eye-off'"
        :type="appendIcon ? 'text' : 'password'"
        :rules="passwordRule"
        required
        @click:append="appendIcon = !appendIcon"
      ></v-text-field>
      <v-text-field
        v-model="password_conf"
        label="パスワード再入力"
        :append-icon="appendIcon ? 'mdi-eye' : 'mdi-eye-off'"
        :type="appendIcon ? 'text' : 'password'"
        required
        @click:append="appendIcon = !appendIcon"
      ></v-text-field>
      <v-checkbox
        v-model="agree"
        label="利用規約に同意する"
      ></v-checkbox>
      <input type="button" value="サインアップ" class="green lighten-1 white--text py-2 px-5 rounded" @click="onSubmit">
    </v-form>
  </div>
</template>

<script>
export default {
  data: () => ({
    tab: null,
    isManager: false,
    email: '',
    password: '',
    password_conf: '',
    agree: false,
    appendIcon: false,
    valid: false,
    emailRules: [
      // 入力がない場合の必須表示、～＠～の形式で バリデーション
      v => !!v || '必須項目です',
      v => /.+@.+/.test(v) || 'メールアドレスの形式が正しくありません'
    ],
    passwordRule: [
      // 入力がない場合の必須表示、8文字以上のバリデーション → 正規表現が分からず未実装
      v => !!v || '必須項目です'
      // v =>  || 'パスワードは8文字以上必要です'
    ],
    planRule: [
      // 入力がない場合の必須表示
      v => !!v || '必須項目です'
    ]
  }),
  computed: {
    idToken () {
      return this.$store.getters.idToken
    }
  },
  methods: {
    toDashboad () {
      this.$router.push('/dashboad')
    },
    onSubmit () {
      // agreeがtrueのとき、authenticationアクションをdispatch
      if (this.agree === true) {
        this.$store.dispatch('signUp', {
          email: this.email,
          password: this.password,
          userType: this.isManager,
          plan: this.plan
        })
      } else {
        // agreeがfalseならば、アラートを表示
        alert('If you want to sign up, you should agree to the term!')
      }
    }
  }
}
</script>
