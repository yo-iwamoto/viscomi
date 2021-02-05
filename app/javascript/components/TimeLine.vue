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
      v-for="ad in shuffledAds"
      class="ad"
      :key="ad.phone_number">
      <Ad :ad="ad" :key="ad.phone_number" v-if="tab == 1" />
    </div>
  </div>
</template>

<script>

export default {
  data: () => ({
    posts: [],
    sortedPosts: [],
    ads: [],
    tabs: ['すべて', '広告', 'イベント', '連絡事項'],
    tab: 0
  }),
  computed: {
    shuffledAds () {
      let result = []
      for (let i = 0; i < this.ads.length; i++) {
        let n = Math.floor(Math.random() * Math.floor(2))
        if (n === 0) {
          result.push(this.ads[i])
        } else {
          result.unshift(this.ads[i])
        }
      }
      this.ads =  result
      return result
    }
  },
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
  mounted () {
    this.$axios.get('/timelines').then(res => {
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