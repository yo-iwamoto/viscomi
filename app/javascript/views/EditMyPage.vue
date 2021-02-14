<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">編集</h1>
    <v-form v-model="valid" class="form" ref="edit_profile_form">
      <Input
        label="名前（ニックネーム）"
        before
        :value="form.name"
        @input="form.name = $event" />
        <!-- 仕様未決定のため保留
      <Input
        label="お住まいの地域の公民館"
        type="select"
        before
        :value="form.follow"
        :items="coms"
        :disabled="isManager"
        @input="form.follow = $event" />
        -->
      <Input
        label="公民館からのメールでの連絡を受け取る"
        type="checkbox"
        before
        :value="!form.mute_contact"
        @input="form.mute_contact = !$event" />
      <p class="text-left grey--text">公民館からのメールは、ご登録のメールアドレスに送信されます。</p>
      <Button value="変更を保存" @click="onSubmit" />
    <router-link to="/"><p style="padding-top: 15px;">変更をキャンセル</p></router-link>
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  // mounted () {
  //   this.$axios.get('/community_centers').then(res => {
  //     for (let i = 0; i < res.data.length; i ++) {
  //       this.coms.push(res.data[i].name)
  //     }
  //   })
  // },
  data: () => ({
    // coms: [],
  }),
  computed: {
    ...mapGetters(["userData", 'followingId']),
    form () {
      return {
        name: this.userData.name,
        mute_contact: this.userData.mute_contact
      }
    },
    isManager () {
      return this.userData.is_manager
    }
  },
  methods: {
    ...mapActions(["editProfile"]),
    onSubmit () {
      if (this.$refs.edit_profile_form.validate()) {
        this.$store.dispatch('editProfile', this.form)
      }
    }
  }
}
</script>
