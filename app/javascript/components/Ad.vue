<template>
  <v-card
    class="mx-auto my-12 text-left"
    max-width="374"
    @click="onClick(url)"
  >

    <v-img
      height="250"
      src="https://cdn.vuetifyjs.com/images/cards/cooking.png"
    ></v-img>

    <v-card-title>カフェ バジリコ</v-card-title>

    <v-card-text>

      <div class="my-4 subtitle-1">
        イタリアンカフェ, 軽食
      </div>

      <div>平日のモーニングがお得です。是非来てください。</div>
    </v-card-text>
    <v-card-text>
      <v-icon>mdi-phone</v-icon>
      080-111-1111</v-card-text>
  </v-card>
</template>

<script>
export default {
  data: () => ({
    url: 'https://google.com'
  }),
  methods: {
    onClick (url) {
      window.open(url, '_blank')
    }
  }
}
</script>