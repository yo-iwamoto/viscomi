<template>
  <v-file-input
    prepend-icon="mdi-camera"
    :label="label"
    @change="onChange"></v-file-input>
</template>

<script>
export default {
  props: {
    label: String
  },
  data: () => ({
    file: new FormData()
  }),
  methods: {
    onChange (value) {
      let image = value
      this.file.append('image', image)
      this.$emit('input', this.file)
    }
  }
}
</script>