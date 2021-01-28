<template>
  <div class="ma-10 new-ad-container">
    <Loading v-if="isLoading" />
    <h1 id="form-title">広告作成</h1>
    <v-form v-model="valid" class="form">
        <v-select
          class="pt-5"
          v-model="form.community_centers"
          :items="communityCenters"
          :menu-props="{ maxHeight: '400' }"
          label="広告を登録する公民館"
          multiple
          hint="複数選択可"
          persistent-hint
        ></v-select>
      <v-text-field
        v-model="form.owner_name"
        label="店舗名"
        :rules="requires"
        required
      ></v-text-field>
      <v-textarea
        v-model="form.content"
        label="説明"
        :rules="requires"
        required
      ></v-textarea>
      <v-text-field
        v-model="form.phone_number"
        label="電話番号（ハイフンなし）"
        :rules="requires"
        required
      ></v-text-field>
      <v-text-field
        v-model="form.url"
        label="リンクのURL"
        :rules="requires"
        required
      ></v-text-field>
      <label for="image">添付画像</label>
      <input id="image" type="file" @change="onChange">
      <br>
      <input type="button" value="投稿" class="colored #white--text py-2 px-5 rounded mb-10" @click="onSubmit">
      <div class="blank my-3"></div>
    </v-form>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import axios from '../plugins/api/axios'
import Loading from '../components/Loading'

export default {
  components: {
    Loading
  },
  data: () => ({
    form: {
      community_centers: null,
      owner_name: '',
      content: '',
      phone_number: '',
      url: '',
      image: new FormData()
    },
    communityCenters: [],
    image: null,
    isLoading: false,
    valid: false,
    requires: [ v => !!v || '必須項目です' ],
  }),
  computed: mapGetters(['followingId']),
  mounted () {
    axios.get('/community_centers').then(res => {
      for (let i = 0; i < res.data.length; i ++) {
        this.communityCenters.push(res.data[i].name)
      }
    })
  },
  methods: {
    onChange (e) {
      this.image = e.target.files[0]
    },
    onSubmit () {
      this.isLoading = true
      this.form.image.append("image", this.image)
      console.log(this.form)
      axios.post('/ads', this.form).then(() => {
        location.reload()
      }).catch(err => {
        console.log(err)
        this.isLoading = false
        alert('エラーが発生しました。')
      })
    }
  }
}
</script>