<template>
  <div>
    <v-file-input
      prepend-icon="mdi-camera"
      :label="label"
      clearable
      @change="onChange"></v-file-input>
    <v-img :src="blobUrl" class="mb-5" max-height="150" width="150" contain></v-img>
  </div>
</template>

<script>
export default {
  props: {
    label: String
  },
  data: () => ({
    image: null,
    file: null
  }),
  methods: {
    onChange (value) {
      this.image = value
      this.file = new FormData()
      this.file.append('image', value)
      this.$emit('input', this.file)
    }
  },
  computed: {
    blobUrl () {
      if (this.image) {
        return window.URL.createObjectURL(this.image)
      }
    }
  }
}
</script>