<template>
  <div class="ma-10 new-post-container">
    <h1 id="form-title">投稿の編集</h1>
    <v-form class="form" ref="edit_post_form" @submit.prevent>
      <base-input
        label="投稿の種類"
        type="select"
        :items="types"
        :value="this.form.type"
        @input="form.type = $event" />
      <base-input
        label="投稿の見出し"
        :value="this.form.title"
        @input="form.title = $event" />
      <base-input
        label="本文"
        type="textarea"
        :value="this.form.content"
        @input="form.content = $event" />
      <base-file-field
        label="添付画像"
        preview="square"
        @input="setImage" />
      <v-img v-if="form.image" class="preview__image mb-5" :src="form.image.url"></v-img>
      <base-button value="変更を保存" @click="onSubmit" />
      <div class="blank my-3"></div>
      <a @click="back"><p>変更をキャンセル</p></a>
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'

export default {
  data: () => ({
    types: ['イベントの告知・報告', '連絡事項'],
    form: {
      type: '',
      title: '',
      content: ''
    },
    image: '',
    requires: [ v => !!v || '必須項目です' ]
  }),
  computed: {
    ...mapGetters(['followingId']),
    pid () {
      return this.$route.query.pid
    }
  },
  mounted () {
    this.$axios.get(`/posts/${this.pid}`).then(res => {
      this.form = res.data
    })
  },
  methods: {
    ...mapMutations(['updateIsLoading']),
    onSubmit () {
      if (this.$refs.edit_post_form.validate()) {
        this.updateIsLoading(true)
        this.$axios.patch(`/posts/${this.pid}`, this.form).then(() => {
          if (this.image) {
            this.updateImage()
          } else {
            this.updateIsLoading(false)
            this.$router.push({ path: 'center', query: { cid: this.followingId } })
          }
        }).catch(() => {
          this.updateIsLoading(false)
          alert('情報に不備があります。再度お確かめください。')
        })
      }
    },
    updateImage () {
      this.$axios.post(`/patch_post_image/${this.pid}`, this.image).then(() => {
        this.updateIsLoading(false)
        this.$router.push({ path: 'center', query: { cid: this.followingId } })
      })
    },
    back () {
      history.back()
    },
    setImage (e) {
      this.form.image = null
      this.image = e
    }
  }
}
</script>

<style scoped>
.blank {
  height: 30px;
}

.preview__image {
  width: 300px;
  height: 200px;
}
</style>