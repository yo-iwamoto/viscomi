<template>
  <div class="mx-10">
    <h1 id="form-title">メール作成</h1>
    <v-form class="form" ref="new_contact_form" @submit.prevent>
      <base-input
        label="メールの件名"
        @input="form.subject = $event" />
      <base-input
        label="本文"
        type="textarea"
        @input="form.content = $event" />
      <base-button value="作成" @click="onSubmit" />
      <div class="blank my-3"></div>
      <router-link :to="{ path: 'index' }"><p style="padding-top: 15px;">変更をキャンセル</p></router-link>
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
    isLoading: false,
    contactId: null
  }),
  computed: mapGetters(['followingId']),
  methods: {
    ...mapMutations(['updateIsLoading']),
    onSubmit () {
      if (this.$refs.new_contact_form.validate()) {
        this.updateIsLoading(true)
        this.$axios.post('/contacts', this.form).then(res => {
          this.contactId = res.data.id
          this.toIndex()
        })
      }
    },
    toIndex () {
      this.updateIsLoading(false)
      this.$router.push('/contacts/index')
    }
  }
}
</script>