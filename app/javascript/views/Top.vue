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
      <h2 id="main-copy" class="font-maru pb-3">ビズコミは、地域のいろいろな
        <br>情報が集まるアプリです
      </h2>
      <h3 class="font-maru">さっそく登録して、のぞいてみましょう</h3>
      <v-divider class="mt-5"></v-divider>
      <div class="top-menu">
        <div class="to-signup">
          <p class="none-if-mobile">初めて利用される方は</p>
          <Link path="/signup" name="はじめる" />
        </div>
        <div class="to-login">
          <p class="none-if-mobile">すでにご登録がお済みの方は</p>
          <Link path="/login" name="ログイン" />
        </div>
      </div>

      <h3 class="mt-5">くわしく</h3>
      <v-icon v-scroll-to="{ el: '#overview', offset: -80 }" x-large class="pa-3 scroll-icon">mdi-chevron-down</v-icon>

      <section id="overview">
        <v-img src="images/introduction/views-without-back.png" contain class="overview-right" />
        <v-container class="text-left overview-left">
          <v-row class="mb-5 oveerview-textbox">
            <h2 class="font-weight-bold">ビズコミ -VISCOMI-</h2>
            <div class="overview-text">
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
      </section>

      <section id="introduction" class="my-10">
        <h2>カンタン！
          <br>登録までの２ステップ
        </h2>
        <v-container class="steps">
          <v-row>
            <v-col cols=12 lg=6 class="step">
              <v-img src="images/introduction/signup.jpg" class="step-img" contain />
              <h2 class="pb-4">新規登録</h2>
              <p>ニックネーム、メールアドレス、お住まいの地域の公民館を登録</p>
            </v-col>
            <!-- <v-col cols=12 lg=4 class="step">
              <v-img src="images/introduction/account_activation.jpg" class="step-img" contain />
              <h2 class="pb-4">メールを確認</h2>
              <p>登録したメールアドレスにメールが届いたメールからアカウントを有効化</p>
            </v-col> -->
            <v-col cols=12 lg=6 class="step">
              <v-img src="images/introduction/views.jpg" class="step-img" contain />
              <h2 class="pb-4">登録完了！</h2>
              <p>地域の情報をのぞいてみよう！
                <br>お得な情報が見つかるかも
              </p>
            </v-col>
          </v-row>
        </v-container>
      </section>

      <section id="get-started">
        <h3>はじめてみましょう！</h3>
        <br>
        <Link path="/signup" name="はじめる" />
        <div class="back">
          <p class="d-inline back">一番上に戻る</p><v-icon v-scroll-to="{ el: '#top-wrapper', offset: -80 }" x-large class="pa-3 scroll-icon">mdi-chevron-up</v-icon>
        </div>
      </section>

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
        { image: `${this.defaultPath}shops.png`,      text: '地域のお店の最新情報'},
        { image: `${this.defaultPath}activities.png`, text: '公民館の活動情報'},
        { image: `${this.defaultPath}events.png`,     text: '自治会のイベント情報'},
        { image: `${this.defaultPath}posts.png`,      text: '行政への意見の提出'}
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
.scroll-icon {
  cursor: pointer;
}
.back {
  margin-top: 100px;
  margin-bottom: 200px;
}
.features {
  width: 80%;
  margin: 0 auto;
  .feature-img {
    height: 75px;
    width: 90px;

  }
}
.overview-text {
  font-size: 1.2rem;
  span {
    font-style: oblique;
  }
}

#introduction {
  .step {
    p {
      max-width: 92%;
      margin: 0 auto;
      font-size: 1.2rem;
    }
  }
}

@media (max-width: 600px) {
  .features {
    width: 100%;
    h3 {
      font-size: 1em;
    }
  }

  .overview-textbox {
    margin: 0 30px;
  }
  .none-if-mobile {
    display: none;
  }
}

@media (max-width: 1000px) {
  .step-img {
    max-height: 350px;
  }
}

@media (min-width: 1000px) {
  #overview {
    margin-top: 150px;
    display: flex;
    justify-content: space-between;
    flex-flow: nowrap row-reverse;
    .overview-right {
      width: 70%;
      transform: translate(50px, -30px)
    }
    .overview-left {
      margin-right: 50px;
    }
    .features {
      width: 100%;
      margin: 0;
    }
  }
  #introduction {
    .steps {
      margin: 0 auto;
      p {
        width: 100%;
      }
    }
  }
}
</style>