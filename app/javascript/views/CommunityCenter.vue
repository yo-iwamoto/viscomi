<template>
  <h2>{{ comPageData }}</h2>
</template>

<script>
export default {
  mounted () {
    this.$store.dispatch('getComPageData', this.comId)
  },
  computed: {
    comId () {
      return this.$route.params.id
    },
    comPageData () {
      return this.$store.getters.comPageData
    }
  }
}
</script>