<template>
  <div class="ma-10 signup-container">
    <h1 id="form-title">公民館情報の編集</h1>
    <v-form class="form" ref="edit_com_form" @submit.prevent>
      <base-input
        label="公民館の名前"
        before
        :value="form.name"
        @input="form.name = $event" />
      <base-input
        label="ひとこと"
        type="middle"
        before
        :value="form.comment"
        @input="form.comment = $event" />
      <base-file-field
        label="プロフィール画像"
        preview="circle"
        @input="setImage" />
      <v-img v-if="getImage" class="preview__image mb-5" :src="getImage.url" />
      <base-button value="変更を保存" @click="onSubmit" />
      <router-link :to="{ path: 'center', query: { cid: followingId } }"><p style="padding-top: 15px;">変更をキャンセル</p></router-link>
    </v-form>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  data: () => ({
    valid: false,
    image: null,
    getImage: null
  }),
  mounted () {
    const getData = () => {
      this.$axios.get(`/community_centers/${this.followingId}`).then(res => {
        this.getImage = res.data.image
      })
    }
    setTimeout(getData, 200)
  },
  computed: {
    ...mapGetters(['followingId', 'userData']),
    form () {
      return {
        name: this.userData.following.name,
        comment: this.userData.following.comment,
        image: this.image
      }
    }
  },
  methods: {
    ...mapActions(["editComPage"]),
    onSubmit () {
      if (this.$refs.edit_com_form.validate()) {
        this.editComPage(this.form)
      }
    },
    setImage (e) {
      this.getImage = null
      this.image = e
    }
  }
}
</script>

<style lang="scss" scoped>
.preview__image {
  border-radius: 50%;
  width: 100px;
  height: 100px;
}
</style>