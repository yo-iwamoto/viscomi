<template>
  <div>
    <v-card-text v-if="sentAt === 'now'">送信処理中<br>アプリを閉じても処理は継続されます。</v-card-text>
    <v-card-text v-else-if="sentAt" class="text-left">送信済み：{{ sentAt }}</v-card-text>

    <v-btn
      v-if="!sentAt"
      class="white--text py-2 rounded"
      color="#243743"
      :to="{ path: 'edit', query: { contactId: contactId } } "
    ><v-icon class="pr-3">mdi-pencil</v-icon>
    編集
    </v-btn>
    <v-btn
      :disabled="!!sentAt"
      @click="onClick"
      class="white--text py-2 rounded"
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
      this.sentAt = 'now'
      this.updateIsLoading(true)
      this.$axios.post(`/contact_send/${this.contactId}`).then(res => {
        this.sentAt = res.data.sent_at
        this.updateIsLoading(false)
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