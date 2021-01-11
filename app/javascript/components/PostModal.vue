<template>
  <v-row justify="center">
    <v-dialog
      v-model="show"
      hide-overlay
      transition="dialog-transition"
      >
      <v-card
        class="mx-auto mb-10"
        >
        <v-img
          src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
          height="200px"
        ></v-img>

        <v-card-title>{{ post.type }}</v-card-title>

        <v-card-subtitle class="text-left">{{ post.title }}</v-card-subtitle>

        <v-car-text class="text-left">{{ post.content }}
        </v-car-text>

        <v-card-actions>
          <v-btn
            class="mx-auto"
            color="cyan lighten-2"
            text
            @click="close"
          >閉じる
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
export default {
  props: {
    post: {
      default: () => ({
        title: '',
        content: ''
      })
    },
    show: {
      default: false
    }
  },
  methods: {
    close () {
      this.$emit('close')
    }
  }
}
</script>