<template>
  <v-dialog
    v-model="dialog"
    max-width="290"
  ><template v-slot:activator="{ on, attrs }">
      <v-btn
        color="#243743"
        dark
        v-bind="attrs"
        v-on="on"
        class="hide white--text"
        ></v-btn>
    </template>
    <v-card>
      <v-card-title class="headline">
        {{ title }}
      </v-card-title>
      <v-card-text>{{ message }}</v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn
          class="white--text"
          color="#243743"
          text
          @click="dialog = false"
        >確認</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    title: {},
    message: {},
    dialog: {
      default: false
    }
  }
}
</script>

<style lang="scss" scoped>
.hide {
  display: none;
}
</style>