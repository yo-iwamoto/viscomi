<template>
  <div class="mx-10">
    <h1 id="form-title">メール編集</h1>
    <v-form class="form" ref="edit_contact_form" @submit.prevent>
      <base-input
        label="メールの件名"
        :value="form.subject"
        @input="form.subject = $event" />
      <base-input
        label="本文"
        type="textarea"
        :value="form.content"
        @input="form.content = $event" />
      <base-button value="変更を保存" @click="onSubmit" />
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
      if (this.$refs.edit_contact_form.validate()) {
        this.$axios.patch(`/contacts/${this.contactId}`, this.form).then(() => {
          this.$router.push({ path: 'index' })
        })
      }
    }
  }
}
</script>