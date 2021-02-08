<template>
  <div id="top-wrapper">

    <!-- 非ログイン時 -->
    
    <template v-if="!loggedIn">
      <Modal v-bind="{
        title: '登録手続き',
        message: 'ご記入のメールアドレスに本人確認用のメールを送信致しました。メールに記載のURLより確認をお願い致します。',
        dialog: signedUp
      }"/>
      <div class="logo-container">
        <img src="images/logo.png" alt="VISCOMI" class="top-logo">
      </div>
      <h2 id="main-copy" class="font-maru pb-3">ビズコミは、お住まいの地域の
        <br>色々な情報を受け取れるサービスです
      </h2>
      <h3 class="font-maru">さっそく登録して、のぞいてみましょう</h3>
      <v-divider class="mt-5"></v-divider>
      <div class="top-menu">
        <div class="to-signup">
          <p>初めて利用される方は</p>
          <Link path="/signup" name="利用者登録" />
        </div>
        <div class="to-login">
          <p>すでにご登録がお済みの方は</p>
          <Link path="/login" name="ログイン" />
        </div>
      </div>

      <div class="overview">
        <v-img src="images/introduction/views-without-back.png" contain class="overview-right" />

        <v-container class="text-left mt-5 overview-left">
          <v-row class="mb-5">
            <h2 class="font-weight-bold">ビズコミ -VISCOMI-</h2>
          </v-row>
          <v-row><div class="overview-text">
            <p>コミュニティ（Community）を可視化（Visualize）します</p>
            <p>これまであなたが知らなかった地域の情報が見つかるかもしれません</p>
          </div></v-row>
          <v-row class="features" no-gutters>
            <v-col
              v-for="(feature, index) in features"
              :key="index"
              cols=12>
              <v-container>
                <v-row align="center">
                  <v-col cols=4 xs=2><v-img :src="feature.image" contain class="feature-img" /></v-col>
                  <v-col cols=8 xs=10><h3 class="text-no-wrap">{{ feature.text }}</h3></v-col>
                </v-row>
              </v-container>
            </v-col>
          </v-row>
        </v-container>
      </div>

    </template>

    <!-- ログイン時 -->
    
    <template v-else>
      <h2 class="font-maru">{{ pageData.name }}</h2>
      <TimeLine />
    </template>

    <!-- 管理者専用 -->

    <template v-if="userData.email == 'viscomi10440@gmail.com'">
      <Link path="/new_ad" name="広告を作成" icon="mdi-clipboard-plus" />
    </template>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data: () => ({
    pageData: {
      name: null
    },
    defaultPath: '/images/introduction/'
  }),
  computed: {
    ...mapGetters(["signedUp", "userData", "loggedIn"]),
    features () {
      return [
        { image: `${this.defaultPath}shops.png`, text: '地域のお店の最新・お得情報'},
        { image: `${this.defaultPath}activities.png`, text: '公民館の活動情報'},
        { image: `${this.defaultPath}events.png`, text: '自治会のイベント情報'},
        { image: `${this.defaultPath}posts.png`, text: 'オンライン目安箱への投書'}
      ]
    }
  },
  mounted () {
    if (this.loggedIn) {
      this.$axios.get('/community_center').then(res => {
        this.pageData = res.data
      })
    }
  }
}
</script>

<style scoped lang="scss">
.features {
  width: 80%;
  margin: 0 auto;
  .feature-img {
    height: 90px;
    width: 90px;
  }
}
.overview-text {
  font-size: 1.1rem;
  span {
    font-style: oblique;
  }
}

@media (max-width: 600px) {
  .features {
    width: 100%;
    h3 {
      font-size: 1em;
    }
  }
}

@media (min-width: 1000px) {
  .overview {
    display: flex;
    margin-top: 100px;
    justify-content: space-between;
    flex-flow: nowrap row-reverse;
    &-right {
      width: 55%;
    }
    &-left {
      margin-right: 50px;
    }
    .features {
      width: 100%;
      margin: 0;
    }
  }
}
</style>