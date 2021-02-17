<template>
  <div>
    <h2 class="mb-5">アンケートページに移動しています。</h2>
    <Link path="/" name="トップページに戻る" icon="mdi-home" />
  </div>
</template>

<script>
export default {
  mounted () {
    let confirmation = confirm('【目安箱】新しいページでアンケートフォームを開いてもよろしいですか？')
    if (confirmation) {
      open('https://forms.gle/oQorFcWkQWwxrNrAA', '_blank')
    } else {
      this.$router.push('/')
    }
  }
}
</script>