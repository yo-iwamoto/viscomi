<template>
  <div class="ma-10 new-post-container">
    <h1 id="form-title">投稿作成</h1>
    <v-form class="form" ref="new_post_form" @sumit.prevent>
      <Input
        label="投稿の種類"
        type="select"
        :items="types"
        @input="form.type = $event" />
      <Input
        label="投稿の見出し"
        @input="form.title = $event" />
      <Input
        label="本文"
        type="textarea"
        @input="form.content = $event" />
      <FileField label="添付画像" @input="postImage = $event" />
      <Button value="投稿" @click="onSubmit" />
      <div class="blank my-3"></div>
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
    postImage: null,
    requires: [ v => !!v || '必須項目です' ]
  }),
  methods: {
    ...mapMutations(['updateIsLoading']),
    onSubmit () {
      if (this.$refs.new_post_form.validate()) {
        this.updateIsLoading(true)
        this.$axios.post('/posts', this.form).then(() => {
          this.attachImage()
        }).catch(() => {
          this.updateIsLoading(false)
          alert('情報に不備があります。再度お確かめください。')
        })
      }
    },
    attachImage () {
      this.$axios.post(`/post_image/${this.followingId}`, this.postImage).then(() => {
        this.updateIsLoading(false)
        this.$router.push({ path: 'center', query: { cid: this.followingId } })
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