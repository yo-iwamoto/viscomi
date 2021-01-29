<template>
  <v-card
    class="mx-auto my-12 text-left"
    max-width="374"
  >

    <v-img
      height="250"
      :src="imageUrl"
    ></v-img>

    <v-card-title class="font-maru">{{ ad.owner_name }}</v-card-title>
    <v-divider></v-divider>

    <v-card-text class="font-maru">
      <div>{{ ad.content }}</div>
    </v-card-text>
    <v-card-text class="font-maru">
      <v-icon>mdi-phone</v-icon>
      {{ ad.phone_number}}</v-card-text>
    <p @click="onClick" class="ad-link text-center py-2 font-maru">詳しくはこちら</p>
  </v-card>
</template>

<script>
export default {
  props: {
    ad: {
      default: () => ({
        owner_name: '',
        content: '',
        phone_number: '',
        ad_image: {
          image: {
            url: null
          }
        },
        community_center_id: 0,
        url: ''
      }),
    }
  },
  data: () => ({
    url: 'https://google.com',
    samplePicks: [
      '/images/sample/nikuzyaga.jpg',
      '/images/sample/pizza.jpg',
      '/images/sample/coffee.jpg',
      '/images/sample/cafe.jpg',
    ]
  }),
  computed: {
    imageUrl () {
      if (this.ad.ad_image !== null) {
        return this.ad.ad_image.image.url
      } else {
        return this.samplePicks[this.n]
      }
    },
    n () {
      return Math.floor(Math.random() * Math.floor(4))
    }
  },
  methods: {
    onClick () {
      window.open(this.ad.url, '_blank')
    }
  }
}
</script>