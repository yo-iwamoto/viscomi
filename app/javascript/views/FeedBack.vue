<template>
  <div class="ma-10">
    <base-modal
      title='フィードバック完了'
      message='ご記入いただいたフィードバックは正常に送信されました。ご意見を元に、アプリを改善していきます。ありがとうございました。'
      toTop="true"
      :dialog="dialog" />
    <h1 id="form-title">フィードバック</h1>
    <v-banner class="banner text-left mx-auto">
      当アプリに関して、改善点、不満、良かった点などございましたら、是非こちらの画面にて、アプリへの意見をお寄せください。
      <br>頂いたご意見は、アプリの改善に役立てられます。
    </v-banner>
    <v-form class="form" ref="feedback_form" @sumit.prevent>
      <base-input
        label="件名"
        @input="form.title = $event" />
      <base-input
        label="本文"
        type="textarea"
        @input="form.content = $event" />
      <base-button value="送信" @click="onSubmit" />
      <div class="blank my-3"></div>
    </v-form>
  </div>
</template>

<script>
import { mapMutations } from 'vuex'
export default {
  data: () => ({
    form: {
      title: null,
      content: null
    },
    dialog: null
  }),
  methods: {
    ...mapMutations(['updateIsLoading']),
    onSubmit () {
      if (this.$refs.feedback_form.validate()) {
        this.updateIsLoading(true)
        this.$axios.post('/feedbacks', { feedback: this.form}).then(() => {
          this.updateIsLoading(false)
          this.dialog = true
        }).catch(err => {
          this.updateIsLoading(false)
        })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@media (min-width: 600px) {
  .banner {
    width: 60%;
  }
}
</style>