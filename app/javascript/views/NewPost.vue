<template>
  <v-stepper v-model="s">
    <h1 id="form-title">投稿作成</h1>
    <v-stepper-items>
      <v-stepper-content step="1">
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
          <Button value="次へ" @click="check" />
          <div class="blank my-3"></div>
        </v-form>
      </v-stepper-content>
      <v-stepper-content step="2">
        <h3>プレビュー</h3>
        <v-card
          elevation="10"
          max-width="700"
          max-height="800"
          class="mx-auto text-left my-5">
          <v-img
            :src="blobUrl"
            max-height="300"
            class="modal-img" />
          <v-card-title class="pb-5">{{ form.title }}</v-card-title>
          <v-card-subtitle>{{ form.type }}</v-card-subtitle>
          <v-divider class="pb-5" />
          <v-card-text class="post-modal-content" style="white-space: pre-wrap;">
            <p v-html="link_activated_content"></p>
          </v-card-text>
          <p class="date">ｘｘ月ｘｘ日</p>
        </v-card>
        <Button value="作成" @click="onSubmit" />
        <p @click="s = 1" class="blue--text my-5">作成画面に戻る</p>
      </v-stepper-content>
    </v-stepper-items>
  </v-stepper>
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
    requires: [ v => !!v || '必須項目です' ],
    s: 1
  }),
  methods: {
    ...mapMutations(['updateIsLoading']),
    check () {
      if (this.$refs.new_post_form.validate()) {
        this.s = 2
      }
    },
    onSubmit () {
      this.updateIsLoading(true)
      this.$axios.post('/posts', this.form).then(() => {
        this.attachImage()
      }).catch(() => {
        this.updateIsLoading(false)
        alert('情報に不備があります。再度お確かめください。')
      })
    },
    attachImage () {
      this.$axios.post(`/post_image/${this.followingId}`, this.postImage).then(() => {
        this.updateIsLoading(false)
        this.$router.push({ path: 'center', query: { cid: this.followingId } })
      }).catch(() => {
        this.isLoading = false
        alert('エラーが発生しました。')
      })
    },
    makeLink (url) { 
      return '<a href="' + url + '" target="_blank">' + url + '</a>' 
    }
  },
  computed: {
    ...mapGetters(['followingId']),
    link_activated_content () {
      return this.form.content.replace(this.url_regex, this.makeLink)
    },
    blobUrl () {
      if (this.postImage) {
        let image = this.postImage.get('image')
        if (image) {
          return window.URL.createObjectURL(image)
        }
      }
    }
  }
}
</script>

<style scoped>
.blank {
  height: 30px;
}
</style>