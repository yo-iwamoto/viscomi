<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">公民館情報の編集</h1>
    <v-form class="form">
      <Input
        label="公民館の名前"
        before
        :value="form.name"
        @input="form.name = $event" />
      <Input
        label="ひとこと"
        type="textarea"
        before
        :value="form.comment"
        @input="form.comment = $event" />
      <Button value="変更を保存" @click="onSubmit" />
      <router-link :to="{ path: 'center', query: { cid: followingId } }"><p style="padding-top: 15px;">変更をキャンセル</p></router-link>
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data: () => ({
    valid: false
  }),
  computed: {
    ...mapGetters(['followingId', 'userData']),
    form () {
      return {
        name: this.userData.following.name,
        comment: this.userData.following.comment
      }
    }
  },
  methods: {
    ...mapActions(["editComPage"]),
    onSubmit () {
      if (this.form.name && this.form.comment) {
        this.editComPage(this.form)
      } else {
        alert('エラーが発生しました。ご入力内容をご確認の上、再度お試し下さい。')
      }
    }
  }
}
</script>