<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">公民館情報の編集</h1>
    <v-form v-model="valid" class="form">
      <v-text-field
        v-model="form.name"
        :value="comData.name"
        label="公民館の名前"
        required
      ></v-text-field>
      <v-textarea
        v-model="form.comment"
        :value="comData.comment"
        label="ひとこと"
        required
      ></v-textarea>
      <input type="button" value="変更を保存" class="cyan lighten-2 white--text py-2 px-5 rounded" @click="onSubmit()">
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data: () => ({
    form: {
      name: '',
      comment: ''
    },
    valid: false,
  }),
  computed: mapGetters(["comData"]),
  methods: {
    ...mapActions(["editComPage"]),
    onSubmit () {
      if (this.form.name && this.form.comment) {
        this.$store.dispatch('editProfile', this.form)
      } else {
        alert('エラーが発生しました。ご入力内容をご確認の上、再度お試し下さい。')
      }
    }
  }
}
</script>