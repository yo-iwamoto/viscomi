<template>
  <v-btn
    @click="onClick"
    class="green lighten-1 white--text py-2 px-5 rounded"
  >{{ name }}</v-btn>
</template>

<script>
export default {
  props: {
    path: {
      required: true
    },
    name: {
      required: true
    }
  },
  methods: {
    onClick () {
      this.$router.push(this.path)
    }
  }
}
</script>
