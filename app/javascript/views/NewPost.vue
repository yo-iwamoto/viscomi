<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">投稿作成</h1>
    <v-form v-model="valid" class="form">
      <v-select
        v-model="type"
        label="投稿の種類"
        :rules="requires"
        :items="types"
        required
      ></v-select>
      <v-text-field
        v-model="title"
        label="投稿の見出し"
        required
      ></v-text-field>
      <v-text-field
        v-model="content"
        label="本文"
        required
      ></v-text-field>
      <v-file-input
        label="添付画像"
        v-model="image"
      ></v-file-input>
      <input type="button" value="投稿" class="green lighten-1 white--text py-2 px-5 rounded" @click="onSubmit">
    </v-form>
  </div>
</template>

<script>
export default {
  data: () => ({
    types: ['イベントの告知', 'イベントの報告', 'ゴミ出し', '連絡事項'],
    type: '',
    title: '',
    content: '',
    image: {},
    requires: [
      // 入力がない場合の必須表示
      v => !!v || '必須項目です'
    ]
  }),
  computed: {
    comData () {
      return this.$store.communityCenterData
    }
  },
  methods: {
    onSubmit () {
      this.$store.dispatch('newPost', {
        "comId": this.comData.id,
        "type": this.type,
        "title": this.title,
        "content": this.content,
        "image": this.image
      })
    }
  }
}
</script>