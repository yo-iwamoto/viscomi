<template>
  <div id="com-page-container">
    <div v-show="isManager" class="link-container">
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

export default {
  data: () => ({
    communityCenter: {
      name: null
    }
  }),
  computed: {
    ...mapGetters(['userData']),
    isManager () {
      return this.userData.is_manager
    },
    cid () {
      return this.$route.query.cid
    }
  },
  mounted () {
    this.$axios.get(`/community_centers/${this.cid}`).then(res => {
      this.communityCenter = res.data
    }).catch(() => {
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