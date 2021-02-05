<template>
  <div>
    <v-card-text v-if="sentAt === 'now'">送信処理中<br>アプリを閉じても処理は継続されます。</v-card-text>
    <v-card-text v-else-if="sentAt" class="text-left">送信済み：{{ sentAt }}</v-card-text>

    <v-btn
      v-if="!sentAt"
      @click="onClick"
      class="white--text py-2ounded"
      color="#243743"
    ><v-icon class="pr-3">mdi-send</v-icon>
    送信
    </v-btn>
  </div>
</template>

<script>
import { mapMutations } from 'vuex'
export default {
  props: {
    contactId: {
      type: Number,
      require: true
    },
    sentAt: {
      type: String,
      require: true
    }
  },
  methods: {
    ...mapMutations(['updateIsLoading']),
    onClick () {
      this.updateIsLoading(true)
      this.sentAt = 'now'
      this.$axios.post(`/contact_send/${this.contactId}`).then(res => {
        this.updateIsLoading(false)
        this.sentAt = res.data.sent_at
        this.$emit('sent', res.data.sent_at)
        location.reload()
      }).catch(() => {
        this.sentAt = null
        this.updateIsLoading(false)
      })
    }
  }
}
</script>