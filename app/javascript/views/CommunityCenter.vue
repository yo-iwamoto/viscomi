<template>
  <div id="com-page-container">
    <div v-show="isManager" class="link-container">
      <div class="to-edit">
        <router-link :to="{ path: 'edit_com', query: { cid: cid } }">
          <v-icon large>mdi-account-cog</v-icon>
        </router-link>
      </div>
    </div>
    <section id="info" class="text-left ml-10 my-5">
      <h2 class="pb-3">{{ communityCenter.name }}</h2>
      <p>管理者：{{ userData.name }}</p>
      <p>登録ユーザー数：{{ communityCenter.followers_number }}</p>
    </section>

    <v-expansion-panels
      v-model="panel"
      multiple>

      <!-- <v-expansion-panel>
        <v-expansion-panel-header @click.once="getFollowers">登録ユーザー</v-expansion-panel-header>
        <v-expansion-panel-content class="text-left">
          <v-virtual-scroll
            :items="followers"
            :item-height="70"
            height="400">
            <template v-slot:default="{ item }">
              <v-list-item>
                <v-list-item-avatar>
                  <v-avatar
                    color="red lighten-3"
                    size="56"
                    class="white--text">
                    {{ item.initial }}
                  </v-avatar>
                </v-list-item-avatar>

                <v-list-item-content>
                  <v-list-item-title>{{ item.name }}</v-list-item-title>
                  <p>{{ item.email }}</p>
                </v-list-item-content>
                <v-icon v-if="!item.mute_contact">mdi-email</v-icon>
              </v-list-item>
            </template>
          </v-virtual-scroll>
          <p class="mt-5"><v-icon>mdi-email</v-icon>アイコンがついていないユーザーは、メール配信設定をオフにしています。</p>
        </v-expansion-panel-content>
      </v-expansion-panel> -->

      <v-expansion-panel>
        <v-expansion-panel-header @click.once="getPosts">投稿</v-expansion-panel-header>
        <v-expansion-panel-content>
          <div
            v-for="post in posts"
            class="post"
            :key="post.id">
            <Post :post="post" :key="post.id" />
          </div>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <v-expansion-panel>
        <v-expansion-panel-header @click.once="getAds">登録されている広告</v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row>
            <v-col
              cols=12 sm=6 lg=4
              v-for="ad in ads"
              class="ad"
              :key="ad.phone_number">
              <Ad :ad="ad" :key="ad.phone_number" />
            </v-col>
          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <v-expansion-panel>
        <v-expansion-panel-header @click.once="getContacts">メール</v-expansion-panel-header>
        <v-expansion-panel-content>
          <Alert :showAlert="true" type="info" comment="この画面ではメールの確認しかできません。メールを作成したり、編集、送信したい場合は、サイドバーの「メール管理」から操作してください。" />
          <template v-for="contact in contacts">
            <v-card :key="contact.id" class="px-4 text-left">
              <v-row>
                <v-card-title>件名：{{ contact.subject }}</v-card-title>
              </v-row>
              <v-row class="gray--text">
                <v-card-text>
                  <p>本文</p>
                  <p style="white-space: pre-wrap;">{{ contact.content }}</p>
                </v-card-text>
              </v-row>
              <v-row>
                <v-card-text class="grey--text">
                  <p v-if="contact.sent_at_formatted">送信済：{{ contact.sent_at_formatted }}</p>
                  <p v-else>未送信（最終更新日：{{ contact.updated_at_formatted }}）</p>
                </v-card-text>
              </v-row>
            </v-card>
            <v-divider :key="contact.subject" class="mb-6"></v-divider>
          </template>
        </v-expansion-panel-content>
      </v-expansion-panel>

    </v-expansion-panels>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data: () => ({
    communityCenter: {
      name: null,
      comment: null,
      followers_number: null
    },
    panel: [],
    readonly: false,
    posts: [],
    ads: [],
    contacts: [],
    followers: []
  }),
  computed: {
    ...mapGetters(['userData', 'isManager']),
    cid () {
      return this.$route.query.cid
    }
  },
  mounted () {
    this.$axios.get(`/community_centers/${this.cid}`).then(res => {
      this.communityCenter = res.data
    }).catch(() => {
      this.$router.push('/')
    })
  },
  methods: {
    getPosts () {
      if (this.isManager) {
        this.$axios.get('/posts').then(res => {
          this.posts = res.data
        })
      }
    },
    getAds () {
      if (this.isManager) {
        this.$axios.get('/ads').then(res => {
          this.ads = res.data
        })
      }
    },
    getContacts () {
      if (this.isManager) {
        this.$axios.get('/contacts').then(res => {
          this.contacts = res.data
        })
      }
    }
  }
}
</script>