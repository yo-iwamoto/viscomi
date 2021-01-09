<template>
  <div>
    <h2>タイムライン</h2>
  </div>
</template>

<script>
import Post from './Post'

export default {
  components: {
    Post
  },
  props: {
    comId: {
      null: false,
      default: ''
    }
  }
}
</script>