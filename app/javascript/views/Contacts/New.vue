<template>
  <div class="mx-10">
    <h1 id="form-title">メール作成</h1>
    <v-form class="form">
      <Input
        label="メールの件名"
        @input="form.subject = $event" />
      <Input
        label="本文"
        type="textarea"
        @input="form.content = $event" />
      <FileField label="添付画像" @input="postImage = $event" />
      <Button value="作成" @click="onSubmit" />
      <div class="blank my-3"></div>
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'

export default {
  data: () => ({
    form: {
      subject: null,
      content: null
    },
    postImage: null,
    isLoading: false,
    contactId: null
  }),
  computed: mapGetters(['followingId']),
  methods: {
    ...mapMutations(['updateIsLoading']),
    onSubmit () {
      this.updateIsLoading(true)
      this.$axios.post('/contacts', this.form).then(res => {
        this.contactId = res.data.id
        if (this.postImage) {
          this.attachImage()
        } else {
          this.toIndex()
        }
      }).catch(() => {
        this.updateIsLoading(false)
        alert('エラーが発生しました。')
      })
    },
    attachImage () {
      this.$axios.post(`/contact_image/${this.contactId}`, this.postImage).then(() => {
        this.toIndex()
      }).catch(() => {
        this.updateIsLoading(false)
        alert('エラーが発生しました。')
      })
    },
    toIndex () {
      this.updateIsLoading(false)
      this.$router.push('/contacts/index')
    }
  }
}
</script>