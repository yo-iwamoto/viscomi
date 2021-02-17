<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">利用者登録</h1>
    <v-form class="form" ref="signup_form" @sumit.prevent>
      <!-- blur時に@inputが発火 -->
      <Input
        v-if="follow"
        disabled
        label="お住まいの地域の公民館"
        type="select"
        :items="communityCenterNames"
        :value="follow"
        @input="follow = $event" />
      <Input
        v-else
        label="お住まいの地域の公民館"
        type="select"
        :items="communityCenterNames"
        @input="follow = $event" />
      <Input
        label="名前（ニックネーム）"
        @input="form.name = $event" />
      <Input
        label="メールアドレス"
        type="email"
        @input="form.email = $event" />
      <Input
        label="パスワード"
        type="password"
        @input="form.password = $event" />
      <Alert :showAlert="showAlert.password" comment="パスワードが一致しません。" />
      <Input
        label="パスワード再入力"
        type="password"
        @input="password_conf = $event" />
      <Alert :showAlert="showAlert.term" comment="ご利用いただくには、利用規約に同意していただく必要があります。" />
      <Term
        :dialog="dialog"
        @agree="closeDialog(true)"
        @disagree="closeDialog(false)"
      />
      <Button value="利用規約" @click="openDialog" />
      <v-checkbox
        v-model="agree"
        label="利用規約に同意する"
      ></v-checkbox>
      <Button value="送信" @click="onSubmit" />
    </v-form>
  </div>
</template>

<script>
import { mapActions, mapGetters, mapMutations } from 'vuex'

export default {
  data: () => ({
    form: {
      name: '',
      email: '',
      password: '',
    },
    follow: '',
    password_conf: '',
    agree: false,
    showAlert: {
      password: false,
      term: false
    },
    openTerm: false,
    communityCenters: [],
    dialog: false
  }),
  computed: {
    ...mapGetters(["loggedIn"]),
    samePass () {
      return this.form.password === this.password_conf
    },
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
      this.$router.push('/mypage')
    } else {
      this.$axios.get('/community_centers').then(res => {
        this.communityCenters = res.data
        if (this.$route.query.cid) {
          this.findCommunityCenter(this.$route.query.cid)
        }
      })
    }
  },
  methods: {
    ...mapActions(["signUp"]),
    ...mapMutations(['updateIsLoading']),
    openDialog () {
      this.dialog = true
    },
    closeDialog (v) {
      this.dialog = false
      this.agree = v
    },
    onSubmit () {
      this.showAlert.term = this.showAlert.password = false
      if (!this.agree) { this.showAlert.term = true }
      if (!this.samePass) { this.showAlert.password = true }
      if (this.$refs.signup_form.validate()) {
        let confirmation = confirm(`登録する公民館は「${this.follow}」でお間違いありませんか？`)
        if (!confirmation) { return }
        this.updateIsLoading(true)
        this.signUp({
          user: this.form,
          follow: this.follow
        })
      }
    },
    findCommunityCenter (query) {
      console.log(this.communityCenters)
      let target = this.communityCenters.filter((item) => {
        if (item.id === Number(query)) {
          return true
        }
      })
      this.follow = target[0].name
    }
  }
}
</script>
