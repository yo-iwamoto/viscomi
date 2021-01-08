<template>
  <h2>タイムライン</h2>
</template>

<script>
import Post from './Post'

export default {
  props: {
    comId: {
      null: false,
      default: ''
    }
  },
  computed: {
    comData () {
      return this.$store.dispatch('getTimeLineData')
    }
  },
  components: {
    Post
  }
}
</script>