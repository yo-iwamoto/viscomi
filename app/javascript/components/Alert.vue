<template>
  <v-alert
    v-model="showAlert"
    dense
    border="left"
    :type="type">
    {{ comment }}
  </v-alert>
</template>

<script>
export default {
  props: {
    showAlert: {
      type: Boolean,
      default: false,
      require: true
    },
    comment: {
      type: String,
      default: false,
      require: true
    },
    type: {
      type: String,
      default: 'warning',
      require: false
    }
  }
}
</script>