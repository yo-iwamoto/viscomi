<template>
  <div>
    <v-file-input
      prepend-icon="mdi-camera"
      :label="label"
      clearable
      @change="onChange"></v-file-input>
    <v-img v-if="preview && blobUrl" class="preview__image mb-5" :src="blobUrl" />
  </div>
</template>

<script>
export default {
  props: {
    label: String,
    preview: {
      type: Boolean,
      require: false,
      default: false
    }
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

<style lang="scss" scoped>
.preview__image {
  border-radius: 50%;
  height: 100px;
  width: 100px;
}
</style>