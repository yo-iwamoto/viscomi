<template>
  <div class="mx-10">
    <h1 id="form-title">メール編集</h1>
    <v-form class="form">
      <Input
        label="メールの件名"
        :value="form.subject"
        @input="form.subject = $event" />
      <Input
        label="本文"
        type="textarea"
        :value="form.content"
        @input="form.content = $event" />
      <FileField label="添付画像" @input="postImage = $event" />
      <Button value="変更を保存" @click="onSubmit" />
      <div class="blank my-3"></div>
      <router-link :to="{ path: 'index' }"><p style="padding-top: 15px;">変更をキャンセル</p></router-link>
    </v-form>
  </div>
</template>

<script>
export default {
  data: () => ({
    form: {
      subject: null,
      content: null
    }
  }),
  computed: {
    contactId () {
      return this.$route.query.contactId
    }
  },
  mounted () {
    this.$axios.get(`/contacts/${this.contactId}`).then(res => {
      this.form = res.data
    })
  },
  methods: {
    onSubmit () {
      this.$axios.patch(`/contacts/${this.contactId}`, this.form).then(() => {
        this.$router.push({ path: 'index' })
      })
    }
  }
}
</script>