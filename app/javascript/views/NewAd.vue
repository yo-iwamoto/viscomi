<template>
  <div class="ma-10 new-ad-container">
    <Loading v-if="isLoading" />
    <h1 id="form-title">広告作成</h1>
    <v-form v-model="valid" class="form">
      <v-text-field
        v-model="form.title"
        label="投稿の見出し"
        required
      ></v-text-field>
      <v-textarea
        v-model="form.content"
        label="本文"
        required
      ></v-textarea>
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

export default {
  computed: {
    ...mapGetters(['comId']),
    form: {
      owner_name: '',
      content: '',
      phone_number: '',
      url: ''
    }
  },
  methods: {
    onSubmit () {
      axios.post('/ads', {
        comId: this.comId,
        ...this.form
      })
    }
  }
}
</script>