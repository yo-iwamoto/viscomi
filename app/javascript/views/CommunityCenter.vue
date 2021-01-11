<template>
  <div id="com-page-container">
    <div v-show="ownPage" class="link-container">
      <div class="to-edit" @click="toEdit">
        <v-icon large>mdi-account-cog</v-icon>
      </div>
      <div class="to-new">
        <Link path="/new-post" name="投稿を作成" icon="mdi-pencil" />
      </div>
    </div>
    <v-img
      src="/images/community_center.png"
      height="400px"
      :alt="pageData.name"
    ></v-img>
    <h1 class="mt-5">{{ pageData.name }}</h1>
    <div class="comInfo mt-5">
      <p>{{ pageData.comment }}</p>
    </div>
    <div class="posts-container">
      <h2>最近の投稿</h2>
    </div>
    <TimeLine />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Link from '../components/Link'
import TimeLine from '../components/TimeLine'
import axios from '../plugins/api/axios'

export default {
  components: {
    Link,
    TimeLine
  },
  data: () => ({
    pageData: {}
  }),
  computed: {
    ...mapGetters([
      "userId",
      "comData"
    ]),
    ownPage () {
      return this.userId === Number(this.$route.params.id)
    }
  },
  mounted () {
    axios.get(`/community_centers/${this.$route.params.id}`).then(res => {
      this.pageData = res.data
    }).catch(err => {
      console.log(err)
      alert('エラーが発生しました。再度お試しください。')
    })
  },
  methods: {
    toEdit () {
      this.$router.push('/edit-com')
    }
  }
}
</script>