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
  computed: {
    ...mapGetters(["userFollowingId"])
  },
  mounted () {
    let id = this.$store.getters.userFollowingId
    axios.get(`/timeline/${id}`).then(res => {
      this.posts = res.data
    })
  }
}
</script>