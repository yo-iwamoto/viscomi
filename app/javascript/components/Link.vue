<template>
  <v-btn
    @click="onClick"
    class="cyan lighten-2 white--text py-2 px-5 rounded"
  ><v-icon v-show="!!icon" class="pr-3">{{ icon }}</v-icon>{{ name }}</v-btn>
</template>

<script>
export default {
  props: {
    path: {
      required: true
    },
    name: {
      required: true
    },
    icon: {
      required: false
    }
  },
  methods: {
    onClick () {
      this.$router.push(this.path)
    }
  }
}
</script>
