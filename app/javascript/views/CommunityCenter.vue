<template>
  <div id="com-page-container">
    <div v-show="ownPage" class="link-container">
      <div class="to-edit" @click="toEdit">
        <v-icon large>mdi-account-cog</v-icon>
      </div>
      <div class="to-new">
        <Link path="/new_post" name="投稿を作成" icon="mdi-pencil" />
      </div>
    </div>
    <h2>{{ communityCenter.name }}</h2>
    <v-img
      src="/images/community_center.png"
      height="150px"
    ></v-img>
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
    communityCenter: {}
  }),
  computed: {
    ...mapGetters([
      "userId",
      "comData",
      "userFollowingId"
    ]),
    ownPage () {
      return this.userId === Number(this.$route.params.id)
    }
  },
  mounted () {
    axios.get('/community_center').then(res => {
      this.communityCenter = res.data
    }).catch(err => {
      console.log(err)
      alert('エラーが発生しました。再度お試しください。')
    })
  },
  methods: {
    toEdit () {
      this.$router.push('/edit_com')
    }
  }
}
</script>