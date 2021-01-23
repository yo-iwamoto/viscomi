<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">プロフィール編集</h1>
    <v-form v-model="valid" class="form">
      <v-text-field
        v-model="form.name"
        label="名前（ニックネーム）"
        required
      ></v-text-field>
      <input type="button" value="変更を保存" class="colored white--text py-2 px-5 rounded" @click="onSubmit()">
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data: () => ({
    valid: false,
  }),
  computed: {
    ...mapGetters(["userData"]),
    form () {
      return {
        name: this.userData.name
      }
    }
  },
  methods: {
    ...mapActions(["editProfile"]),
    onSubmit () {
      if (this.form.name !== '') {
        this.$store.dispatch('editProfile', this.form)
      } else {
        alert('エラーが発生しました。ご入力内容をご確認の上、再度お試し下さい。')
      }
    }
  }
}
</script>
