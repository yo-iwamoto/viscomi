<template>
  <div>
    <v-card
      class="mx-auto mb-10"
      max-width="600"
      @click="modal = true"
    >
      <v-menu offset-y absolute right class="tool-wrapper" v-if="post.community_center_id === comId">
        <template v-slot:activator="{ on, attrs }">
          <v-icon
            v-bind="attrs"
            v-on="on"
          >mdi-dots-horizontal</v-icon>
        </template>
        <v-list>
          <v-list-item @click="toEdit">編集（未実装）</v-list-item>
          <v-list-item @click="toDelete">削除</v-list-item>
        </v-list>
      </v-menu>

      <div class="post-flex">
        <div class="post-text-box text-left">
          <v-card-title>{{ post.title }}</v-card-title>

          <v-card-subtitle v-if="post.content" class="text-left">{{ heading(post.content) }}</v-card-subtitle>
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
import axios from '../plugins/api/axios'
import { mapGetters } from 'vuex'
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
        },
        community_center_id: 0
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
      if (str.length > 25) {
        return str.substr(0, 25) + '...'
      } else {
        return str
      }
    },
    toDelete () {
      let confirmation = confirm('投稿を削除しますか？')
      if (confirmation) {
        axios.delete(`/posts/${this.post.id}`).then(() => {
          location.reload()
        }).catch(err => {
          alert('エラーが発生しました。')
        })
      }
    },
    toEdit () {
      
    }
  },
  computed: {
    ...mapGetters(['comId']),
    thumbUrl () {
      if (this.post.post_image && this.post.post_image.image && this.post.post_image.image.thumb) {
        return this.post.post_image.image.thumb.url
      }
    }
  }
}
</script>