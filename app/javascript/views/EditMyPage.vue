<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">プロフィール編集</h1>
    <v-form v-model="valid" class="form">
      <v-text-field
        v-model="form.name"
        label="名前（ニックネーム）"
        required
      ></v-text-field>
      <v-select
        v-model="form.follow"
        label="お住まいの地域の公民館"
        :rules="requires"
        :items="coms"
        required
      ></v-select>
      <input type="button" value="変更を保存" class="colored white--text py-2 px-5 rounded" @click="onSubmit()">
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  mounted () {
    this.$axios.get('/community_centers').then(res => {
      for (let i = 0; i < res.data.length; i ++) {
        this.coms.push(res.data[i].name)
      }
    })
  },
  data: () => ({
    valid: false,
    coms: [],
    requires: [ v => !!v || '必須項目です' ]
  }),
  computed: {
    ...mapGetters(["userData"]),
    form () {
      return {
        name: this.userData.name,
        follow: this.userData.following.name
      }
    }
  },
  methods: {
    ...mapActions(["editProfile"]),
    onSubmit () {
      if (this.form.name && this.form.follow) {
        this.$store.dispatch('editProfile', this.form)
      } else {
        alert('エラーが発生しました。ご入力内容をご確認の上、再度お試し下さい。')
      }
    }
  }
}
</script>
