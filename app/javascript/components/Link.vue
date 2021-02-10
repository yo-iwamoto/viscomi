<template>
  <v-btn
    @click="onClick"
    class="white--text px-5 rounded"
    color="#243743">
    <v-icon v-show="!!icon" class="pr-3">{{ icon }}</v-icon>
    <p>{{ name }}</p>
  </v-btn>
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

<style lang="scss" scoped>
p {
  font-size: 15px;
  margin: auto 0;
}
@media (max-width: 600px) {
  p {
    font-size: 14px;
  }
}
</style>