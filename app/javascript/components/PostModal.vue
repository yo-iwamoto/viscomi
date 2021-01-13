<template>
  <v-row justify="center">
    <v-dialog
      v-model="show"
      hide-overlay
      max-width="700px"
      transition="dialog-transition"
      >
      <v-card
        elevation="24"
        class="mx-auto"
        >

        <v-img :src="imageUrl"></v-img>
        <v-card-title>{{ post.title }}</v-card-title>

        <v-card-subtitle>{{ post.type }}</v-card-subtitle>
      
        <v-divider></v-divider>

        <v-card-text>{{ post.content }}</v-card-text>

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
    show: {
      default: false
    },
    formatted_date: {
      default: null
    }
  },
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
      }
    }
  }
}
</script>