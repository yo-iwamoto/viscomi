<template>
  <div>
    <h1 class="mb-10">メール一覧</h1>
    <template v-for="contact in contacts">
      <v-card :key="contact.id" class="px-4">
        <v-row class="text-left">
          <v-card-title>{{ contact.subject }}</v-card-title>
        </v-row>
        <v-row class="text-left gray--text">
          <v-card-text>
            <p style="white-space: pre-wrap;">{{ contact.content }}</p>
          </v-card-text>
        </v-row>
        <v-row>
          <v-card-text>
            <Send
              :contactId="contact.id"
              :sentAt="contact.sent_at_formatted"
              @sent="contacts[contact.id-1].sent_at_formatted = $event" />
          </v-card-text>
        </v-row>
      </v-card>
      <v-divider :key="contact.subject" class="mb-6"></v-divider>
    </template>
  </div>
</template>

<script>
export default {
  data: () => ({
    contacts: []
  }),
  mounted () {
    this.$axios.get('/contacts').then(res => {
      console.log(res)
      this.contacts = res.data
    })
  },
  methods: {
    heading (str) {
      if (str.length > 50) {
        return str.substr(0, 50) + '...'
      } else {
        return str
      }
    }
  }
}
</script>