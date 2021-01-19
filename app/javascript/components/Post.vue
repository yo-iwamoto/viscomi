<template>
  <div>
    <v-card
      class="mx-auto mb-10"
      max-width="600"
      @click="modal = true"
    >
      <div class="post-flex">
        <div class="post-text-box text-left">
          <v-card-title>{{ post.title }}</v-card-title>

          <v-card-subtitle class="text-left">{{ heading(post.content) }}</v-card-subtitle>
        </div>

        <div class="post-image-box">
          <v-img :src="thumbUrl"></v-img>
        </div>
      </div>

      <p class="date">{{ post.formatted_date }}</p>
    </v-card>
    <PostModal
      v-show="modal"
      :post="post"
      :showProp="modal"
      @close="modal = false"
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
            thumb: {
              url: null
            }
          }
        }
      }),
    formatted_date: {
      default: null
    }
    }
  },
  data: () => ({
    // モーダルのオンオフ
    modal: false
  }),
  methods: {
    heading (str) {
      if (str.length > 35) {
        return str.substr(0, 35) + '...'
      } else {
        return str
      }
    }
  },
  computed: {
    thumbUrl () {
      if (this.post.post_image && this.post.post_image.image && this.post.post_image.image.thumb) {
        console.log(this.post)
        return this.post.post_image.image.thumb.url
      }
    }
  }
}
</script>