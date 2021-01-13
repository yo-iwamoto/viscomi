<template>
  <div>
    <v-card
      class="mx-auto mb-10"
      max-width="600"
    >
      <v-img
        :src="imageUrl"
        max-height="150px"
      ></v-img>

      <v-card-title>{{ post.title }}</v-card-title>

      <v-card-subtitle class="text-left">{{ heading(post.content) }}</v-card-subtitle>

      <p class="date">{{ post.formatted_date }}</p>

      <v-card-actions>
        <v-btn
          class="mx-auto"
          color="cyan lighten-2"
          text
          @click="modal = !modal"
        >
          もっと見る
        </v-btn>
      </v-card-actions>
    </v-card>
    <PostModal
      v-show="modal"
      :post="post"
      :show="modal"
      @close="modal = !modal"
    />
  </div>
</template>

<script>
import PostModal from './PostModal'

export default {
  components: {
    PostModal
  },
  props: {
    post: {
      default: () => ({
        title: '',
        content: '',
        post_image: {
          image: {
            url: null
          }
        }
      }),
    formatted_date: {
      default: null
    }
    }
  },
  data: () => ({
    modal: false
  }),
  methods: {
    heading (str) {
      if (str.length > 50) {
        return str.substr(0, 50) + '...'
      } else {
        return str
      }
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