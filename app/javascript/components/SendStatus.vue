<template>
  <div>
    <v-card-text v-if="nowProcessing">送信処理中<br>アプリを閉じても処理は継続されます。</v-card-text>
    <v-card-text v-else-if="sentAt" class="text-left">送信済み：{{ sentAt }}</v-card-text>

    <v-btn
      v-else
      class="white--text py-2 rounded"
      color="#243743"
      :to="{ path: 'edit', query: { contactId: contactId } } "
    ><v-icon class="pr-3">mdi-pencil</v-icon>
    編集
    </v-btn>
    <v-btn
      :disabled="sentAt || nowProcessing"
      @click="onClick"
      class="white--text py-2 rounded"
      color="#243743"
    ><v-icon class="pr-3">mdi-send</v-icon>
    送信
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    contactId: {
      type: Number,
      require: true
    },
    sentAt: {
      type: String,
      require: true
    },
    nowProcessing: {
      type: Boolean,
      require: true,
      default: false
    }
  },
  methods: {
    onClick () {
      // 処理中でなければ、startをemit→now_processingカラムを更新し、POST
      if (!this.nowProcessing) {
        this.$emit('start')
        this.$axios.post(`/contacts/send?contact=${this.contactId}`).then(res => {
          this.sentAt = res.data.sent_at
          this.$emit('sent', res.data.sent_at)
          window.location.reload()
        })
      }
    }
  }
}
</script>