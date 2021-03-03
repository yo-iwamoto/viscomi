<template>
  <div>
    <h2 class="mb-5">アンケートページに移動しています。</h2>
    <p class="mb-10">画面が自動で切り替わらない場合は<a href="https://forms.gle/oQorFcWkQWwxrNrAA" class="pa-3">こちらをクリック</a></p>
    <base-link path="/" name="トップページに戻る" icon="mdi-home" />
  </div>
</template>

<script>
export default {
  mounted () {
    open('https://forms.gle/oQorFcWkQWwxrNrAA', '_blank')
  }
}
</script>

<style lang="scss" scoped>
a {
  font-size: 1.2rem;
}
</style>