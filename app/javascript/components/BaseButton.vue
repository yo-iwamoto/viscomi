<template>
  <input
    type="button"
    :value="value"
    @click="click"
    class="colored white--text py-2 px-5 rounded">
</template>

<script>
export default {
  props: {
    value: {
      type: String,
      require: true,
      default: '送信'
    }
  },
  methods: {
    click () {
      this.$emit('click')
    }
  }
}
</script>