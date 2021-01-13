<template>
  <div id="timeline-container" class="mt-5">
    <v-tabs v-model="tab" class="mb-10 px-auto tabs-container">
      <v-row no-gutters>
        <v-col v-for="tab in tabs" :key="tab">
          <v-tab class="py-4">{{ tab }}</v-tab>
        </v-col>
      </v-row>
    </v-tabs>
    <div
      v-for="post in sortedPosts"
      class="post"
      :key="post.id">
      <Post :post="post" :key="post.id" />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import axios from '../plugins/api/axios'
import Post from './Post'

export default {
  components: {
    Post
  },
  props: {
    comId: {
      null: false,
      default: ''
    }
  },
  data: () => ({
    posts: [],
    sortedPosts: [],
    tabs: ['すべて', 'イベント', 'ゴミ出し', '連絡事項'],
    tab: 0
  }),
  watch: {
    // userFollowingId () {
    //   axios.get(`/timeline/${this.userFollowingId}`).then(res => {
    //     this.posts = res.data
    //   })
    // },
    tab () {
      if (this.tab === 0) {
        this.sortedPosts = this.posts
      } else if (this.tab === 1) {
        this.sort('イベントの告知・報告')
      } else if (this.tab === 2) {
        this.sort('ゴミ出しの案内')
      } else {
        this.sort('連絡事項')
      }
    }
  },
  computed: {
    ...mapGetters(["userFollowingId"])
  },
  mounted () {
    axios.get(`/timeline/${this.userFollowingId}`).then(res => {
      this.posts = this.sortedPosts = res.data
    })
  },
  methods: {
    sort (str) {
      console.log('called')
      this.sortedPosts = []
      for (let i = 0; i < this.posts.length; i ++) {
        console.log(i)
        if (this.posts[i].type == str) {
          this.sortedPosts.push(this.posts[i])
        }
      }
    }
  }
}
</script>