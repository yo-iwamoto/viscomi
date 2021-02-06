<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">プロフィール編集</h1>
    <v-form v-model="valid" class="form">
      <Input
        label="名前（ニックネーム）"
        before
        :value="form.name"
        @input="form.name = $event" />
      <Input
        label="お住まいの地域の公民館"
        type="select"
        before
        :value="form.follow"
        :items="coms"
        :disabled="isManager"
        @input="form.follow = $event" />
      <Input
        label="公民館からのメールでの連絡を受け取らない"
        type="checkbox"
        before
        :value="form.mute_notification"
        @input="form.mute_notification = $event" />
      <p class="text-left grey--text">公民館からのメールは、ご登録のメールアドレスに送信されます。</p>
      <Button value="変更を保存" @click="onSubmit" />
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  mounted () {
    this.$axios.get('/community_centers').then(res => {
      for (let i = 0; i < res.data.length; i ++) {
        this.coms.push(res.data[i].name)
      }
    })
  },
  data: () => ({
    valid: false,
    coms: [],
    requires: [ v => !!v || '必須項目です' ]
  }),
  computed: {
    ...mapGetters(["userData"]),
    form () {
      return {
        name: this.userData.name,
        follow: this.userData.following.name,
        mute_notification: this.userData.mute_notification
      }
    },
    isManager () {
      return this.userData.is_manager
    }
  },
  methods: {
    ...mapActions(["editProfile"]),
    onSubmit () {
      console.log(this.form.mute_notification)
      if (this.form.name && this.form.follow) {
        this.$store.dispatch('editProfile', this.form)
      } else {
        alert('エラーが発生しました。ご入力内容をご確認の上、再度お試し下さい。')
      }
    }
  }
}
</script>
