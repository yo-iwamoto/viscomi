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
  computed: {
    ...mapGetters(["userFollowingId"]),
    posts () {
      axios.get(`/timeline/${this.userFollowingId}`).then(res => {
        return res.data
      })
    }
  }
}
</script>