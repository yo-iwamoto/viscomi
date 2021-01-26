<template>
  <v-card
    class="mx-auto my-12 text-left"
    max-width="374"
    @click="onClick(url)"
  >

    <v-img
      height="250"
      :src="imageUrl"
    ></v-img>

    <v-card-title>{{ ad.owner_name }}</v-card-title>

    <v-card-text>
      <div>{{ ad.content }}</div>
    </v-card-text>
    <v-card-text>
      <v-icon>mdi-phone</v-icon>
      {{ ad.phone_number}}</v-card-text>
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
    url: 'https://google.com'
  }),
  computed: {
    imageUrl () {
      if (this.ad.ad_image !== null) {
        return this.ad.ad_image.image.url
      }
    }
  },
  methods: {
    onClick (url) {
      window.open(url, '_blank')
    }
  }
}
</script>