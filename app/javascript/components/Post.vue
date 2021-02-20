<template>
  <div>
    <v-card
      class="mx-auto"
      max-width="600"
      @click="openModal"
    >
      <div class="tool-wrapper">
        <v-menu offset-y absolute right v-if="isManager && isManagePage">
          <template v-slot:activator="{ on, attrs }">
            <v-icon
              class="icon"
              v-bind="attrs"
              v-on="on"
            >mdi-dots-horizontal</v-icon>
          </template>
          <v-list>
            <v-list-item @click="toEdit">編集</v-list-item>
            <v-list-item @click="toDelete">削除</v-list-item>
          </v-list>
        </v-menu>
      </div>

      <div class="post-flex">
        <div class="post-image-box">
          <v-img height="100" width="100" :src="thumbUrl"></v-img>
        </div>

        <div class="post-text-box text-left">
          <v-card-text class="post-title font-maru">{{ post.title }}</v-card-text>
        </div>
        <p class="date font-maru">{{ post.formatted_date }}</p>
      </div>

    </v-card>
    <v-dialog
      v-model="modal"
      hide-overlay
      transition="dialog-transition"
      max-width="700"
      max-height="800">
      <v-card
        elevation="24"
        class="mx-auto">
        <v-img
          :src="imageUrl"
          max-height="300"
          class="modal-img"
          @click="zoomImage = true" />
          <v-card-title class="pb-5">{{ post.title }}</v-card-title>
          <v-card-subtitle>{{ post.type }}</v-card-subtitle>
          <v-divider class="pb-5" />
          <v-card-text class="post-modal-content" style="white-space: pre-wrap;">
            <p v-html="link_activated_content"></p>
          </v-card-text>
          <p class="date">{{ post.formatted_date }}</p>
          <v-card-actions>
            <v-btn
              class="mx-auto"
              color="cyan lighten-2"
              text dark
              @click="modal = false">閉じる</v-btn>
          </v-card-actions>
        </v-card>
        <v-overlay v-if="zoomImage" @click="zoomImage = false">
          <v-icon @click="zoomImage = false" x-large>mdi-close</v-icon>
          <v-img :src="imageUrl" contain class="mx-auto zoom-image" />
        </v-overlay>
      </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'

export default {
  props: {
    post: {
      default: () => ({
        id: '',
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
      open: {
        require: false,
        default: false
      }
    }
  },
  data: () => ({
    // モーダルのオンオフ
    modal: false,
    samplePicks: [
      '/images/sample/gomi.jpg',
      '/images/sample/kosodate.jpg',
      '/images/sample/hanabi.jpg'
    ],
    zoomImage: false
  }),
  computed: {
    ...mapGetters(['userData', 'modalState']),
    thumbUrl () {
      if (this.post.post_image && this.post.post_image.image && this.post.post_image.image.thumb) {
        return this.post.post_image.image.thumb.url
      } else {
        // デプロイ時削除
        return this.samplePicks[this.n]
      }
    },
    imageUrl () {
      if (this.post.post_image) {
        if (this.post.post_image.image) {
          return this.post.post_image.image.url
        }
      } else {
        // デプロイ時削除
        return this.samplePicks[this.n]
      }
    },
    isManager () {
      return this.userData.is_manager
    },
    isManagePage () {
      return !!this.$route.query.cid
    },
    link_activated_content () {
      return this.post.content.replace(this.url_regex, this.makeLink)
    },
    // デプロイ時削除
    n () {
      return Math.floor(Math.random() * Math.floor(3))
    }
  },
  watch: {
    modal () {
      if (this.modal) {
        this.updateModalState(true)
      } else {
        this.updateModalState(false)
      }
    }
  },
  methods: {
    ...mapMutations(['updateModalState']),
    heading (str) {
      if (str.length > 25) {
        return str.substr(0, 25) + '...'
      } else {
        return str
      }
    },
    openModal () {
      if (!this.modalState) {
        this.modal = true
      }
    },
    toDelete () {
      let confirmation = confirm('投稿を削除しますか？')
      if (confirmation) {
        this.$axios.delete(`/posts/${this.post.id}`).then(() => {
          location.reload()
        }).catch(() => {
          alert('エラーが発生しました。')
        })
      }
    },
    toEdit () {
      this.$router.push({ path: 'edit_post', query: { pid: this.post.id } })
    },
    makeLink (url) { 
      return '<a href="' + url + '" target="_blank">' + url + '</a>' 
    }
  }
}
</script>

<style lang="scss" scoped>
.zoom-image {
  max-width: 90%;
}

@media (min-width: 600px) {
  .zoom-image {
    max-width: 500px;
  }
}
</style>