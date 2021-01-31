<template>
  <div class="ma-10 new-post-container">
    <Loading v-if="isLoading" />
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
      <v-textarea
        v-model="form.content"
        label="本文"
        required
      ></v-textarea>
      <label for="image">添付画像</label>
      <input id="image" type="file" @change="onChange">
      <br>
      <input type="button" value="投稿" class="colored #white--text py-2 px-5 rounded mb-10" @click="onSubmit">
      <div class="blank my-3"></div>
    </v-form>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Loading from '../components/Loading'

export default {
  components: {
    Loading
  },
  data: () => ({
    types: ['イベントの告知・報告', '連絡事項'],
    form: {
      type: '',
      title: '',
      content: ''
    },
    image: null,
    postImage: new FormData(),
    requires: [ v => !!v || '必須項目です' ],
    valid: false,
    isLoading: false
  }),
  methods: {
    onSubmit () {
      this.isLoading = true
      this.$axios.post('/posts', this.form).then(() => {
        this.attachImage()
      }).catch(() => {
        this.isLoading = false
        alert('情報に不備があります。再度お確かめください。')
      })
    },
    onChange (e) {
      this.image = e.target.files[0]
    },
    attachImage () {
      this.postImage.set('image', this.image)
      axios.post(`/post_image/${this.followingId}`, this.postImage).then(() => {
        this.$router.push(`/center/${this.followingId}`)
      }).catch(() => {
        this.isLoading = false
        alert('エラーが発生しました。')
      })
    }
  },
  computed: mapGetters(['followingId'])
}
</script>

<style scoped>
.blank {
  height: 30px;
}
</style>