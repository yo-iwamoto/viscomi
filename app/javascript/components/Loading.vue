<template>
  <div>
    <v-overlay>
      <v-progress-circular
        :size="50"
        color="primary"
        indeterminate
      />
    </v-overlay>
  </div>
</template>

<script>
export default {
}
</script>

<style lang="scss" scoped>
.v-progress-circular {
  margin: 1rem;
  position: absolute;
}
</style>