<template>
  <v-row justify="center">
    <v-dialog
      v-model="show"
      hide-overlay
      transition="dialog-transition"
      max-width="700"
      max-height="800"
      >
      <v-card
        elevation="24"
        class="mx-auto"
        >

        <v-img
          :src="imageUrl"
          max-height="300"
          class="modal-img"
          @click="zoomImg = true"
        ></v-img>
        <v-card-title class="pb-5">{{ post.title }}</v-card-title>

        <v-card-subtitle>{{ post.type }}</v-card-subtitle>
      
        <v-divider class="pb-5"></v-divider>

        <v-card-text class="post-modal-content" style="white-space: pre-wrap;">{{ post.content }}</v-card-text>

        <p class="date">{{ post.formatted_date }}</p>

        <v-card-actions>
          <v-btn
            class="mx-auto"
            color="cyan lighten-2"
            text
            dark
            @click="close"
          >閉じる
          </v-btn>
        </v-card-actions>
      </v-card>
      <v-dialog
        v-model="zoomImg"
      >
        <v-card>
          <v-icon @click="zoomImg = false">mdi-close-circle-outline</v-icon>
          <v-img
            :src="imageUrl"
            contain
            max-heght="500"
          ></v-img>
        </v-card>
      </v-dialog>
    </v-dialog>
  </v-row>
</template>

<script>
export default {
  props: {
    post: {
      default: () => ({
        title: '',
        content: '',
        post_image: null
      })
    },
    showProp: {
      default: false
    },
    formatted_date: {
      default: null
    }
  },
  data: () => ({
    zoomImg: false,
    samplePicks: [
      '/images/sample/gomi.jpg',
      '/images/sample/kosodate.jpg',
      '/images/sample/hanabi.jpg'
    ]
  }),
  methods: {
    close () {
      this.$emit('close')
    }
  },
  computed: {
    imageUrl () {
      if (this.post.post_image) {
        if (this.post.post_image.image) {
          return this.post.post_image.image.url
        }
      } else {
        return this.samplePicks[this.n]
      }
    },
    show () {
      return this.showProp
    },
    n () {
      return Math.floor(Math.random() * Math.floor(3))
    }
  }
}
</script>