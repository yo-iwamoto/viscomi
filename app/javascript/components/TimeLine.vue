<template>
  <div id="timeline-container" class="mt-5">
    <v-tabs v-model="tab" class="mb-10 px-auto tabs-container">
      <v-row no-gutters>
        <v-col v-for="tab in tabs" :key="tab">
          <v-tab class="py-4 px-0">{{ tab }}</v-tab>
        </v-col>
      </v-row>
    </v-tabs>
    <div
      v-for="post in sortedPosts"
      class="post"
      :key="post.id">
      <Post :post="post" :key="post.id" />
    </div>
    <div
      v-for="ad in ads"
      class="ad"
      :key="ad.phone_number">
      <Ad :ad="ad" :key="ad.phone_number" v-if="tab == 1" />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import axios from '../plugins/api/axios'
import Post from './Post'
import Ad from './Ad'

export default {
  components: {
    Post,
    Ad
  },
  data: () => ({
    posts: [],
    sortedPosts: [],
    ads: [],
    tabs: ['すべて', '広告', 'イベント', '連絡事項'],
    tab: 0
  }),
  watch: {
    tab () {
      if (this.tab === 0) {
        this.sortedPosts = this.posts
      } else if (this.tab === 1) {
        this.sortedPosts = null
      } else if (this.tab === 2) {
        this.sort('イベントの告知・報告')
      } else {
        this.sort('連絡事項')
      }
    }
  },
  computed: mapGetters(['userFollowingId']),
  mounted () {
    axios.get('/timeline').then(res => {
      this.posts = this.sortedPosts = res.data.posts
      this.ads = res.data.ads
    })
  },
  methods: {
    sort (str) {
      this.sortedPosts = []
      for (let i = 0; i < this.posts.length; i ++) {
        if (this.posts[i].type == str) {
          this.sortedPosts.push(this.posts[i])
        }
      }
    }
  }
}
</script>