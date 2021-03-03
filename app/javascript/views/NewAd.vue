<template>
  <v-stepper v-model="s" class="pt-5">
    <h1 id="form-title">広告作成</h1>
    <v-stepper-items>
      <v-stepper-content step="1">
        <v-form class="form" ref="new_ad_form" @sumit.prevent>
          <base-input
            label="広告を登録する公民館"
            type="select"
            multiple
            :items="communityCenters"
            @input="form.community_centers = $event" />
          <base-input
            label="店舗名"
            @input="form.owner_name = $event" />
          <base-input
            label="ひとこと"
            type="middle"
            @input="form.content = $event" />
          <base-input
            label="電話番号"
            @input="form.phone_number = $event" />
          <base-input
            label="リンクのURL"
            @input="form.url = $event" />
          <base-file-field label="添付画像" @input="postImage = $event" />
          <base-button value="次へ" @click="check" />
          <div class="blank my-3"></div>
        </v-form>
      </v-stepper-content>
      <v-stepper-content step="2">
        <h3>プレビュー</h3>
        <v-card
          class="mx-auto my-4 text-left"
          max-width="374">

          <v-img
            height="250"
            :src="blobUrl" />

          <v-card-title class="font-maru">{{ form.owner_name }}</v-card-title>
          <v-divider></v-divider>

          <v-card-text class="font-maru">
            <div>{{ form.content }}</div>
          </v-card-text>
          <v-card-text class="font-maru" v-if="form.phone_number">
            <v-icon>mdi-phone</v-icon>
            <a href="#">{{ form.phone_number}}</a>
          </v-card-text>
            <p class="ad-link py-3 font-maru text-center"><a :href="form.url">詳しくはこちら</a></p>
        </v-card>
        <base-button value="登録" @click="onSubmit" />
        <p @click="s = 1" class="blue--text my-5">作成画面に戻る</p>
      </v-stepper-content>
    </v-stepper-items>
  </v-stepper>
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
    isLoading: false,
    s: 1
  }),
  computed: {
    ...mapGetters(['followingId']),
    blobUrl () {
      if (this.postImage) {
        let image = this.postImage.get('image')
        if (image) {
          return window.URL.createObjectURL(image)
        }
      }
    }
  },
  mounted () {
    this.$axios.get('/community_centers').then(res => {
      for (let i = 0; i < res.data.length; i ++) {
        this.communityCenters.push(res.data[i].name)
      }
    })
  },
  methods: {
    ...mapMutations(['updateIsLoading']),
    check () {
      if (this.$refs.new_ad_form.validate()) {
        this.s = 2
      }
    },
    onSubmit () {
      this.updateIsLoading(true)
      this.$axios.post('/ads', this.form).then(() => {
        this.attachImage()
      }).catch(() => {
        this.updateIsLoading(false)
        alert('エラーが発生しました。')
      })
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