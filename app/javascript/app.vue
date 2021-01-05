<template>
  <div id="app">
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  data: () => ({
    message: 'hello vue!'
  })
}
</script>

<style scoped lang="scss">
p {
  font-size: 2em;
  text-align: center;
}
</style>
