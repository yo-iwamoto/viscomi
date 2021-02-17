<template>
  <div>
    <h2 class="mb-5">アンケートページに移動しています。</h2>
    <Link path="/" name="トップページに戻る" icon="mdi-home" />
  </div>
</template>

<script>
export default {
  mounted () {
    open('https://forms.gle/oQorFcWkQWwxrNrAA')
  }
}
</script>