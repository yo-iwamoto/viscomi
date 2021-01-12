<template>
  <div id="timeline-container" class="mt-5">
    <div
      v-for="post in posts"
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
    posts: []
  }),
  watch: {
    userFollowingId () {
      axios.get(`/timeline/${this.userFollowingId}`).then(res => {
        this.posts = res.data
      })
    }
  },
  computed: {
    ...mapGetters(["userFollowingId"])
  },
  mounted () {
    axios.get(`/timeline/${this.userFollowingId}`).then(res => {
      this.posts = res.data
    })
  } 
}
</script>