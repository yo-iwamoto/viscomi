<template>
  <div class="ma-10">
    <base-modal
      title='パスワード再設定'
      message='ご記入のメールアドレスにパスワード再設定用のメールを送信致しました。メールに記載のURLより手続きをお願いいたします。'
      toTop="true"
      :dialog="showDialog" />
    <h2 id="form-title" class="mb-5">パスワード再設定</h2>
    <p>ご登録のメールアドレスに、パスワード再設定用のリンクを送信いたします。</p>
    <v-form class="form" ref="new_password_reset_form" @submit.prevent>
      <base-alert :showAlert="showAlert" comment="登録されていないメールアドレスです" />
      <base-input
        label="ご登録のメールアドレス"
        type="email"
        @input="form.email = $event" />
      <base-button value="再設定" @click="onSubmit" />
    </v-form>
  </div>
</template>

<script>
import { mapMutations } from 'vuex'
export default {
  data: () => ({
    form: {
      email: null
    },
    showAlert: false,
    showDialog: false
  }),
  methods: {
    ...mapMutations(['updateIsLoading']),
    onSubmit () {
      if (this.$refs.new_password_reset_form.validate()) {
        this.updateIsLoading(true)
        this.$axios.post('/password_resets', this.form).then(() => {
          this.showDialog = true
          this.updateIsLoading(false)
        }).catch(err => {
          this.updateIsLoading(false)
          if (err.response.status == 401) {
            this.showAlert = true
          }
        })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@media (min-width: 600px) {
  .form {
    max-width: 50%;
  }
}
</style>