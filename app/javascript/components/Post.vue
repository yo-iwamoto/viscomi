<template>
  <div>
    <v-card
      class="mx-auto my-0"
      max-width="600"
      @click="modal = true"
    >
      <div class="tool-wrapper">
        <v-menu offset-y absolute right v-if="isManager">
          <template v-slot:activator="{ on, attrs }">
            <v-icon
              class="icon"
              v-bind="attrs"
              v-on="on"
            >mdi-dots-horizontal</v-icon>
          </template>
          <v-list>
            <v-list-item @click="toEdit">編集（未実装）</v-list-item>
            <v-list-item @click="toDelete">削除</v-list-item>
          </v-list>
        </v-menu>
      </div>

      <div class="post-flex">
        <div class="post-image-box">
          <v-img height="100" width="100" :src="thumbUrl"></v-img>
        </div>

        <div class="post-text-box text-left">
          <v-card-text class="post-title">{{ post.title }}</v-card-text>
        </div>
        <p class="date">{{ post.formatted_date }}</p>
      </div>

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
        community_center_id: 0,
        formatted_date: ''
      }),
    }
  },
  data: () => ({
    // モーダルのオンオフ
    modal: false,
    samplePicks: [
      '/images/sample/gomi.jpg',
      '/images/sample/kosodate.jpg',
      '/images/sample/hanabi.jpg'
    ]
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
        }).catch(() => {
          alert('エラーが発生しました。')
        })
      }
    },
    toEdit () {
      
    }
  },
  computed: {
    ...mapGetters(['userData']),
    thumbUrl () {
      if (this.post.post_image && this.post.post_image.image && this.post.post_image.image.thumb) {
        return this.post.post_image.image.thumb.url
      } else {
        return this.samplePicks[this.n]
      }
    },
    isManager () {
      return this.userData.is_manager
    },
    n () {
      return Math.floor(Math.random() * Math.floor(3))
    }
  }
}
</script>