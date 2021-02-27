<template>
  <v-stepper v-model="s">
    <v-stepper-items>
      <v-stepper-content step="1" class="pa-0">
        <v-container class="stepper pa-0">
          <v-row class="image-container mb-5 first"></v-row>
          <v-row class="middle">
            <p class="mx-auto">地域のお店の最新情報・お得情報が
              <br>もりだくさん
            </p>
          </v-row>
          <v-row class="navigation ma-0" @click="s = 2">
            <p class="mx-auto pt-2">つぎへ</p>
          </v-row>
        </v-container>
      </v-stepper-content>

      <v-stepper-content step="2" class="pa-0">
        <v-container class="stepper pa-0">
          <v-row class="image-container mb-5 second"></v-row>
          <v-row class="middle">
            <p class="mx-auto">お住まいの地域コミュニティの
              <br>最新情報まで
            </p>
          </v-row>
          <v-row class="navigation ma-0" @click="s = 3">
            <p class="mx-auto pt-2">つぎへ</p>
          </v-row>
        </v-container>
      </v-stepper-content>

      <v-stepper-content step="3" class="pa-0">
        <v-container class="stepper pa-0">
          <v-row class="image-container mb-5 third"></v-row>
          <v-row class="middle"></v-row>
          <v-row class="navigation ma-0" @click="toTop">
            <p class="mx-auto pt-2">はじめる</p>
          </v-row>
        </v-container>
      </v-stepper-content>


    </v-stepper-items>
    <v-stepper-header>
      <v-stepper-step
        :complete="s > 1"
        step="1"
        color="#243743"
        class="step"
        @click="s = 1" />

      <v-divider></v-divider>

      <v-stepper-step
        :complete="s > 2"
        step="2"
        color="#243743"
        class="step"
        @click="s = 2" />

      <v-divider></v-divider>

      <v-stepper-step
        :complete="s > 3"
        step="3"
        color="#243743"
        class="step"
        @click="toThird" />
    </v-stepper-header>
  </v-stepper>
</template>

<script>
export default {
  data: () => ({
    s: 1
  }),
  methods: {
    toThird () {
      if (this.s !== 1) {
        this.s = 3
      }
    },
    toTop () {
      this.$router.push('/')
    }
  }
}
</script>

<style lang="scss" scoped>
.stepper {
  height: 80vh;
  .image-container {
    height: 70%;
    background-size: contain;
    background-position: center center;
    &.first {
      background-image: url("/images/guide/first.png")
    }
    &.second {
      background-image: url("/images/guide/second.png")
    }
    &.third {
      background-image: url("/images/guide/third.png")
    }
  }
  .middle {
    height: 20%;
  }
  .navigation {
    height: 10%;
    width: 100%;
    font-size: 1.3rem;
    color: white;
    background-color: rgba($color: skyblue, $alpha: 0.7);
    cursor: pointer;
  }
}

@media (min-width: 600px) {
  .middle {
    font-size: 1.3rem;
  }
}


.step {
  cursor: pointer;
  transition: transform .3s;
  transform: scale(1.3);
  &:active {
    transition: transform .3s;
    transform: scale(1.7)
  }
}
</style>