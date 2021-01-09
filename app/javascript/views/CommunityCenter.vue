<template>
  <div id="com-page-container">
    <div v-show="ownPage" class="to-new">
      <Link path="/new-post" name="投稿を作成" icon="mdi-pencil" />
    </div>
    <h1 class="mt-5">{{ pageData.name }}</h1>
    <div class="comInfo mt-5">
      <p>こんにちは</p>
    </div>
    <div class="posts-container">
      <h2>最近の投稿</h2>
    </div>
    <Post/>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Link from '../components/Link'
import Post from '../components/Post'
import axios from '../plugins/api/axios'

export default {
  components: {
    Link,
    Post
  },
  data: () => ({
    pageData: {}
  }),
  computed: {
    ...mapGetters([
      "userId",
      "comData",
      "comUserId"
    ]),
    ownPage () {
      return this.userId === this.comUserId
    }
  },
  mounted () {
    axios.get(`/community_centers/${this.$route.params.id}`).then(res => {
      this.pageData = res.data
    }).catch(err => {
      console.log(err)
      alert('エラーが発生しました。再度お試しください。')
    })
  }
}
</script>