<template>
  <div class="ma-10">
    <Modal
      title='パスワード再設定完了'
      message='パスワードが正常に変更されました。ログイン画面に移動します。'
      toLogin="true"
      :dialog="dialog" />
    <h1 id="form-title">パスワード再設定</h1>
    <v-form class="form" ref="password_reset_form">
      <Input
        label="パスワード"
        type="password"
        @input="form.user.password = $event" />
      <Alert :showAlert="showAlert" comment="パスワードが一致しません。" />
      <Input
        label="パスワード再入力"
        type="password"
        @input="password_conf = $event" />
      <Button value="再設定" @click="onSubmit" />
    </v-form>
  </div>
</template>

<script>
import { mapMutations } from 'vuex'

export default {
  data: () => ({
    form: {
      user: {
        password: null
      }
    },
    password_conf: null,
    showAlert: false,
    dialog: false
  }),
  computed: {
    uid () {
      return this.$route.params.id
    }
  },
  watch: {
    dialog () {
      if (!this.dialog) {
        this.$router.push('/login')
      }
    }
  },
  methods: {
    ...mapMutations(['updateIsLoading']),
    onSubmit () {
      if (this.form.user.password !== this.password_conf) {
        this.showAlert = true
      } else if (this.$refs.password_reset_form.validate()) {
        this.updateIsLoading(true)
        this.$axios.patch(`/password_resets/${this.uid}`, this.form).then(() => {
          this.updateIsLoading(false)
          this.dialog = true
        }).catch(err => {
          console.log(err)
        })
      }
    }
  }
}
</script>