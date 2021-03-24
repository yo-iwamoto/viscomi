<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">利用者登録</h1>
    <v-form class="form" ref="signup_form" @submit.prevent>
      <!-- blur時に@inputが発火 -->
      <base-input
        label="お住まいの地域の公民館"
        type="select"
        :items="communityCenterNames"
        :value="follow"
        :disabled="disableSelect"
        @input="follow = $event" />
      <base-input
        label="名前（ニックネーム）"
        placeholder="ご自身のお名前を入力してください。"
        @input="form.name = $event" />
      <base-input
        label="メールアドレス"
        type="email"
        placeholder="ご自身の普段使うメールアドレスを入力してください。"
        @input="form.email = $event" />
      <base-input
        label="パスワード"
        type="password"
        @input="form.password = $event" />
      <base-alert :showAlert="showAlert.password" comment="パスワードが一致しません。" />
      <!-- <base-input
        label="パスワード再入力"
        type="password"
        @input="password_conf = $event" /> -->
      <base-alert :showAlert="showAlert.term" comment="ご利用いただくには、利用規約に同意していただく必要があります。" />
      <the-term
        :dialog="dialog"
        @agree="closeDialog(true)"
        @disagree="closeDialog(false)"
      />
      <base-button value="利用規約" @click="openDialog" />
      <v-checkbox
        v-model="agree"
        label="利用規約に同意する"
      ></v-checkbox>
      <base-button value="送信" @click="onSubmit" />
      <p class="ma-5">すでにアカウントをお持ちですか？ <br><span @click="toLogIn" class="blue--text text--lighten-2 signin-span">ログイン</span></p>
    </v-form>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

export default {
  data: () => ({
    form: {
      name: '',
      email: '',
      password: '',
    },
    follow: '',
    // password_conf: '',
    agree: false,
    showAlert: {
      // password: false,
      term: false
    },
    openTerm: false,
    communityCenters: [],
    dialog: false,
    disableSelect: false
  }),
  computed: {
    ...mapGetters(["loggedIn"]),
    // samePass () {
    //   return this.form.password === this.password_conf
    // },
    communityCenterNames () {
      let names = []
      for (let i = 0; i < this.communityCenters.length; i ++) {
        names.push(this.communityCenters[i].name)
      }
      return names
    }
  },
  mounted () {
    if (this.loggedIn) {
      // ログイン済みの場合，マイページへ移動
      this.$router.push('/')
    } else {
      // 未ログインの場合，公民館データを取得
      this.$axios.get('/community_centers').then(res => {
        this.communityCenters = res.data
        if (this.$route.query.cid) {
          // さらにcidのクエリがある場合，公民館をサーチ
          this.findCommunityCenter(this.$route.query.cid)
        }
      })
    }
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
      this.showAlert.term = false
      // 利用規約とパスワードについては，ルールとは別途アラート
      // if (!this.agree || !this.samePass) {
      if (!this.agree) {
          this.showAlert.term = true
        // if (!this.samePass) {
        //   this.showAlert.password = true
        // }
      } else if (this.$refs.signup_form.validate()) {
        let confirmation = confirm(`登録する公民館は「${this.follow}」でお間違いありませんか？`)
        if (!confirmation) { return }
        this.signUp({
          user: this.form,
          follow: this.follow
        })
      }
    },
    findCommunityCenter (query) {
      // クエリの指定する公民館を特定して，followに代入，inputをdisabled
      let target = this.communityCenters.filter((item) => {
        if (item.id === Number(query)) {
          return true
        }
      })
      this.follow = target[0].name
      this.disableSelect = true
    },
    toLogIn () {
      this.$router.push('/login')
    }
  }
}
</script>
