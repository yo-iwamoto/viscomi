<template>
  <v-row justify="center">
    <v-dialog
      v-model="show"
      hide-overlay
      transition="dialog-transition"
      >
      <v-card
        class="mx-auto mb-10"
        >
        <v-img
          :src="imageUrl"
          height="200px"
        ></v-img>

        <v-card-title>{{ post.type }}</v-card-title>

        <v-card-subtitle class="text-left">{{ post.title }}</v-card-subtitle>

        <v-card-text class="text-left">{{ post.content }}
        </v-card-text>

        <v-card-actions>
          <v-btn
            class="mx-auto"
            color="cyan lighten-2"
            text
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