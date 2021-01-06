<template>
  <div id="404container">
    <h2>お探しのページは見つかりませんでした</h2>
    <p>404 Not Found...</p>
    <Link path="/" name="トップページへ" />
  </div>
</template>

<script>
import Link from '../components/Link'

export default {
  components: {
    Link
  }
}
</script>