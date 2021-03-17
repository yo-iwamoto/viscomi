<template>
  <div>
    <div class="ml-auto new-btn">
      <v-btn
        to="/contacts/new"
        rounded
        class="white--text px-3 py-4 new-link"
        color="#243743">
        <v-icon class="pr-3">mdi-plus</v-icon>
        <p class="new-link-text">新規作成</p>
      </v-btn>
    </div>
    <h1 class="mb-10">メール一覧</h1>
    <template v-for="contact in contacts">
      <v-card :key="contact.id" class="px-4">
        <div class="tool-wrapper">
          <v-menu offset-y absolute right>
            <template v-slot:activator="{ on, attrs }">
              <v-icon
                class="icon"
                v-bind="attrs"
                v-on="on">mdi-dots-horizontal
              </v-icon>
            </template>
            <v-list>
              <v-list-item @click="toEdit(contact.id)">編集</v-list-item>
              <v-list-item @click="deleteMail(contact.id)">削除</v-list-item>
            </v-list>
          </v-menu>
        </div>
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
            <send-status
              :contactId="contact.id"
              :sentAt="contact.sent_at_formatted"
              :nowProcessing="contact.now_processing"
              @start="loadTimeout"
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
    this.load()
  },
  methods: {
    heading (str) {
      if (str.length > 50) {
        return str.substr(0, 50) + '...'
      } else {
        return str
      }
    },
    load () {
      this.$axios.get('/contacts').then(res => {
        this.contacts = res.data
      })
    },
    loadTimeout () {
      setTimeout(this.load(), 1000)
    },
    toEdit (id) {
      this.$router.push(`/contacts/edit?contactId=${id}`)
    },
    deleteMail (id) {
      let confirmation = confirm('本当に削除しますか？')
      if (confirmation) {
        this.$axios.delete(`/contacts/${id}`).then(() => {
          location.reload()
        })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.new-btn {
  width: 150px;
}

.new-link {
  transform: translateY(-20px);
  .new-link-text {
    font-size: 17px;
    margin: auto 0;
  }
}
@media (max-width: 600px) {
  .new-link-text {
    font-size: 18px;
  }
}
</style>