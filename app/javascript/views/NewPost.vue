<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">投稿作成</h1>
    <v-form v-model="valid" class="form">
      <label for="image">添付画像</label>
      <br><br>
      <input id="image" type="file" @change="onChange">
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
      <v-textarea
        v-model="form.content"
        label="本文"
        required
      ></v-textarea>
      <input type="button" value="投稿" class="colored #white--text py-2 px-5 rounded" @click="onSubmit">
    </v-form>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import axios from '../plugins/api/axios'

export default {
  data: () => ({
    types: ['イベントの告知・報告', 'ゴミ出しの案内', '連絡事項'],
    form: {
      type: '',
      title: '',
      content: ''
    },
    image: null,
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
        comId: this.comId,
        ...this.form
      }).then(() => {
        this.postFormImage()
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。再度お試しください。')
      })
    },
    onChange (e) {
      this.image = e.target.files[0]
    },
    postFormImage () {
      let formData = new FormData()
      formData.append("image", this.image)
      axios.post(`/post_image/${this.comId}`, formData).then(() => {
        this.$router.push(`/center/${this.comId}`)
      }).catch(err => {
        console.log(err)
        alert('エラーが発生しました。')
      })
    }
  }
}
</script>