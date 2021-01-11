<template>
  <div>
    <v-card
      class="mx-auto mb-10"
      max-width="600"
      height="400"
    >
      <v-img
        src="https://cdn.vuetifyjs.com/images/cards/sunshine.jpg"
        height="200px"
      ></v-img>

      <v-card-title>{{ post.title }}</v-card-title>

      <v-card-subtitle>{{ post.content }}</v-card-subtitle>

      <v-card-actions>
        <v-btn
          color="cyan lighten-2"
          text
        >
          もっと見る
        </v-btn>

        <v-spacer></v-spacer>
      </v-card-actions>
    </v-card>
  </div>
</template>

<script>
import Modal from './Modal'

export default {
  props: {
    post: {
      default: () => ({
        title: "あけましておめでとうございます。",
        content: "今年もよろしくお願い致します。"
      })
    }
  }
}
</script>