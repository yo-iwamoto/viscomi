<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">投稿作成</h1>
    <v-form v-model="valid" class="form">
      <v-select
        v-model="form.type"
        label="投稿の種類"
        :rules="requires"
        :items="types"
        required
      ></v-select>
      <v-text-field
        v-model="form.title"
        label="投稿の見出し"
        required
      ></v-text-field>
      <v-text-field
        v-model="form.content"
        label="本文"
        required
      ></v-text-field>
      <input type="button" value="投稿" class="cyan lighten-2 white--text py-2 px-5 rounded" @click="onSubmit">
    </v-form>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import axios from '../plugins/api/axios'

export default {
  data: () => ({
    types: ['イベントの告知', 'イベントの報告', 'ゴミ出し', '連絡事項'],
    form: {
      type: '',
      title: '',
      content: ''
    },
    requires: [
      // 入力がない場合の必須表示
      v => !!v || '必須項目です'
    ],
    valid: false
  }),
  computed: mapGetters(["comId"]),
  methods: {
    onSubmit () {
      axios.post('/posts', {
        "comId": this.comId,
        "type": this.form.type,
        "title": this.form.title,
        "content": this.form.content
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。再度お試しください。')
      })
    }
  }
}
</script>