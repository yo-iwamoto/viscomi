<template>
  <div id="com-page-container">
    <div v-show="ownPage" class="to-new">
      <Link path="/new-post" name="投稿を作成" icon="mdi-pencil" />
    </div>
    <h1 class="mt-5">{{ comPageData.name }}</h1>
    <div class="comInfo mt-5">
      <p>{{ dammyText }}</p>
    </div>
    <div class="posts-container">
      <h2>最近の投稿</h2>
    </div>
  </div>
</template>

<script>
import Link from '../components/Link'

export default {
  data: () => ({
    ownPage: true
  }),
  mounted () {
    this.$store.dispatch('getComPageData', this.$route.params.id)
  },
  computed: {
    comId () {
      return this.$route.params.id
    },
    comPageData () {
      return this.$store.getters.comPageData
    },
    userData () {
      return this.$store.getters.userData
    },
    dammyText () {
      return Array(10+1).join(`こんにちは。${this.comPageData.name}です。${this.userData.name}が運営しています。`)
    }
  },
  components: {
    Link
  }
}
</script>