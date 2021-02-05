<template>
  <div class="ma-10 new-post-container">
    <h1 id="form-title">投稿の編集</h1>
    <v-form class="form">
      <Input
        label="投稿の種類"
        type="select"
        :items="types"
        :value="this.form.type"
        @input="form.type = $event" />
      <Input
        label="投稿の見出し"
        :value="this.form.title"
        @input="form.title = $event" />
      <Input
        label="本文"
        type="textarea"
        :value="this.form.content"
        @input="form.content = $event" />
      <Button value="変更を保存" @click="onSubmit" />
      <div class="blank my-3"></div>
      <router-link :to="{ path: 'center', query: { cid: followingId } }"><p style="padding-top: 15px;">変更をキャンセル</p></router-link>
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
      this.updateIsLoading(true)
      this.$axios.patch(`/posts/${this.pid}`, this.form).then(() => {
        this.updateIsLoading(false)
        this.$router.push({ path: 'center', query: { cid: this.followingId } })
      }).catch(() => {
        this.updateIsLoading(false)
        alert('情報に不備があります。再度お確かめください。')
      })
    }
  }
}
</script>

<style scoped>
.blank {
  height: 30px;
}
</style>