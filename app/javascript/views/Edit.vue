<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">プロフィール編集</h1>
    <v-form v-model="valid" class="form">
      <v-file-input v-model="img" label="添付画像"></v-file-input>
      <v-text-field
        v-model="form.name"
        label="名前（ニックネーム）"
        required
      ></v-text-field>
      <input type="button" value="変更を保存" class="green lighten-1 white--text py-2 px-5 rounded" @click="onSubmit">
    </v-form>
  </div>
</template>

<script>
export default {
  mounted () {
    this.form = this.$store.getters.userData
  },
  data: () => ({
    form: {},
    img: [],
    valid: false,
  }),
  computed: {
    userId () {
      return this.$store.getters.userId
    }
  },
  methods: {
    onSubmit () {
      // agreeがtrueのとき、authenticationアクションをdispatch
      if (this.form.name !== '') {
        this.$store.dispatch('editProfile', this.form, this.img)
      } else {
        alert('エラーが発生しました。ご入力内容をご確認の上、再度お試し下さい。')
      }
    }
  }
}
</script>
