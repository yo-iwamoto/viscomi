<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">公民館情報の編集</h1>
    <v-form v-model="valid" class="form">
      <v-text-field
        v-model="form.name"
        label="公民館の名前"
        required
      ></v-text-field>
      <v-textarea
        v-model="form.comment"
        label="ひとこと"
        required
      ></v-textarea>
      <input type="button" value="変更を保存" class="colored white--text py-2 px-5 rounded" @click="onSubmit()">
      <router-link :to="`/center/${comData.id}`"><p style="padding-top: 15px;">変更をキャンセル</p></router-link>
    </v-form>
  </div>
</template>

<script>
import axios from '../plugins/api/axios'
import { mapGetters, mapActions } from 'vuex'

export default {
  data: () => ({
    valid: false,
    form: {
      name: null,
      comment: null
    }
  }),
  mouted () {
    axios.get('/community_center').then(res => {
      this.form = res.data
    })
  },
  computed: {
    ...mapGetters(["followingId"])
  },
  methods: {
    ...mapActions(["editComPage"]),
    onSubmit () {
      if (this.form.name && this.form.comment) {
        this.$store.dispatch('editComPage', this.form)
      } else {
        alert('エラーが発生しました。ご入力内容をご確認の上、再度お試し下さい。')
      }
    }
  }
}
</script>