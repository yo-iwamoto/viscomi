<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">利用者登録</h1>
    <v-form v-model="valid" class="form">
      <v-text-field
        v-model="form.name"
        label="名前（ニックネーム）"
        :rules="nameRule"
        required
      ></v-text-field>
      <v-text-field
        v-model="form.email"
        label="メールアドレス"
        :rules="emailRules"
        required
      ></v-text-field>
      <!-- append-icon属性は横の表示アイコン
      表示のアイコンをクリック時表示／非表示アイコンが切り替わり、
      同時にtypeがpassword, textと切り替わることで、
      非表示アイコン時、入力文字を伏せ字にする-->
      <v-text-field
        v-model="form.password"
        label="パスワード"
        :append-icon="appendIcon ? 'mdi-eye' : 'mdi-eye-off'"
        :type="appendIcon ? 'text' : 'password'"
        :rules="passwordRules"
        required
        @click:append="appendIcon = !appendIcon"
      ></v-text-field>
      <v-alert
      v-model="alertPass"
      dense
      border="left"
      type="warning"
      dismissible
      >パスワードと再入力が一致しません。
      </v-alert>
      <v-text-field
        v-model="password_conf"
        label="パスワード再入力"
        :append-icon="appendIconConf ? 'mdi-eye' : 'mdi-eye-off'"
        :type="appendIconConf ? 'text' : 'password'"
        required
        @click:append="appendIconConf = !appendIconConf"
      ></v-text-field>
      <v-select
        v-model="form.follow"
        label="お住まいの地域の公民館"
        :rules="nameRule"
        :items="coms"
        required
      ></v-select>
      <v-alert
      v-model="alertTerm"
      dense
      border="left"
      type="warning"
      dismissible
      >ご利用いただくには、<strong>利用規約に同意</strong>していただく必要があります。
      </v-alert>
      <Term
        :dialog="dialog"
        @agree="closeDialog(true)"
        @disagree="closeDialog(false)"
      />
      <v-btn class="colored white--text" color="#243743" @click="openDialog">利用規約</v-btn>
      <v-checkbox
        v-model="agree"
        label="利用規約に同意する"
      ></v-checkbox>
      <input type="button" value="登録" class="colored white--text py-2 px-5 rounded" @click="onSubmit">
    </v-form>
  </div>
</template>

<script>
import axios from '../plugins/api/axios'
import { mapActions, mapGetters } from 'vuex'
import Term from '../components/Term'

export default {
  components: {
    Term
  },
  data: () => ({
    form: {
      name: '',
      email: '',
      password: '',
      follow: ''
    },
    password_conf: '',
    agree: false,
    appendIcon: false,
    appendIconConf: false,
    valid: false,
    alertPass: false,
    alertTerm: false,
    openTerm: false,
    coms: [],
    emailRules: [
      // 入力がない場合の必須表示、～＠～の形式で バリデーション
      v => !!v || '必須項目です',
      v => /.+@.+/.test(v) || 'メールアドレスの形式が正しくありません'
    ],
    passwordRules: [
      // 入力がない場合の必須表示、8文字以上のバリデーション → 正規表現が分からず未実装
      v => !!v || '必須項目です'
      // v =>  || 'パスワードは8文字以上必要です'
    ],
    nameRule: [
      // 入力がない場合の必須表示
      v => !!v || '必須項目です'
    ],
    dialog: false
  }),
  computed: mapGetters(["loggedIn"]),
  mounted () {
    if (this.loggedIn) {
      this.$router.push('/mypage')
    }
    axios.get('/com_names').then(res => {
      for (let i = 0; i < res.data.length; i ++) {
        this.coms.push(res.data[i].name)
      }
    })
  },
  methods: {
    ...mapActions(["signUp"]),
    openDialog () {
      this.dialog = true
    },
    closeDialog (v) {
      this.dialog = false
      this.agree = v
    },
    onSubmit () {
      // agreeがtrueのとき、authenticationアクションをdispatch
      if (this.agree && this.form.password === this.password_conf) {
        console.log(this.form.name)
        this.signUp({
          user: this.form
        })
      } else if (!this.agree) {
        // 利用規約部分にalert
        this.alertTerm = true
      } else {
        // パスワード再入力にalert
        this.alertPass = true
      }
    }
  }
}
</script>
