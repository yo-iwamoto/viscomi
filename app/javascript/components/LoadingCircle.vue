<template>
  <div v-if="isLoading">
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
import { mapGetters } from 'vuex'

export default ({
  computed: mapGetters(['isLoading'])
})
</script>


<style lang="scss" scoped>
.v-progress-circular {
  margin: 1rem;
  position: absolute;
}
</style>