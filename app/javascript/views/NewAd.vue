<template>
  <div class="ma-10 new-ad-container">
    <h1 id="form-title">広告作成</h1>
    <v-form class="form" ref="new_ad_form" @sumit.prevent>
      <Input
        label="広告を登録する公民館"
        type="select"
        multiple
        :items="communityCenters"
        @input="form.community_centers = $event" />
      <Input
        label="店舗名"
        @input="form.owner_name = $event" />
      <Input
        label="ひとこと"
        @input="form.content = $event" />
      <Input
        label="電話番号"
        @input="form.phone_number = $event" />
      <Input
        label="リンクのURL"
        @input="form.url = $event" />
      <FileField label="添付画像" @input="postImage = $event" />
      <Button value="登録" @click="onSubmit" />
      <div class="blank my-3"></div>
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'

export default {
  data: () => ({
    form: {
      community_centers: null,
      owner_name: '',
      content: '',
      phone_number: '',
      url: '',
    },
    communityCenters: [],
    postImage: null,
    isLoading: false
  }),
  computed: mapGetters(['followingId']),
  mounted () {
    this.$axios.get('/community_centers').then(res => {
      for (let i = 0; i < res.data.length; i ++) {
        this.communityCenters.push(res.data[i].name)
      }
    })
  },
  methods: {
    ...mapMutations(['updateIsLoading']),
    onSubmit () {
      if (this.$refs.new_ad_form.validate()) {
        this.updateIsLoading(true)
        this.$axios.post('/ads', this.form).then(() => {
          this.attachImage()
        }).catch(() => {
          this.updateIsLoading(false)
          alert('エラーが発生しました。')
        })
      }
    },
    attachImage () {
      this.$axios.post(`/ad_image`, this.postImage).then(() => {
        location.reload()
      }).catch(() => {
        this.updateIsLoading(false)
        alert('エラーが発生しました。')
      })
    }
  }
}
</script>