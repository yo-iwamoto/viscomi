<template>
    <div class="ma-10 signup-container">
    <h1 id="form-title">管理者登録</h1>
    <div class="form-desc">
      <p>公民館登録を行うフォームです。必要情報を入力して登録ボタンを押します。</p>
      <p>現在ログイン中のユーザーに対して登録が行われるので、下記のユーザーで間違いないかお確かめください。</p>
      <p>登録後、マイページから公民館管理者ページにアクセスできるようになります。</p>
    </div>
    <template v-if="!userData">
      <p>******************************************</p>
      <p>ログインしているユーザーがいません。先にログインする必要があります。</p>
      <p>******************************************</p>
    </template>
    <template v-else-if="userData.is_manager">
      <p>******************************************</p>
      <p>既に管理者登録済です。情報をご確認ください。</p>
      <p>******************************************</p>
    </template>
    <template v-else>
      <h3 class="mb-5">ユーザー</h3>
      <p>{{ userData.name }}</p>
      <p>{{ userData.email }}</p>
    </template>
    <v-form v-model="valid" class="form">
      <v-text-field
        :disabled="userData.is_manager ? true : false"
        v-model="form.name"
        label="公民館の名前"
        required
      ></v-text-field>
      <!-- append-icon属性は横の表示アイコン
      表示のアイコンをクリック時表示／非表示アイコンが切り替わり、
      同時にtypeがpassword, textと切り替わることで、
      非表示アイコン時、入力文字を伏せ字にする-->
      <v-text-field
        :disabled="userData.is_manager ? true : false"
        v-model="form.password"
        label="登録用パスワード"
        :append-icon="appendIcon ? 'mdi-eye' : 'mdi-eye-off'"
        :type="appendIcon ? 'text' : 'password'"
        required
        @click:append="appendIcon = !appendIcon"
      ></v-text-field>
      <input type="button" value="登録" class="colored white--text py-2 px-5 rounded" @click="onSubmit">
    </v-form>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  data: () => ({
    valid: false,
    appendIcon: false,
    form: {
      userId: 0,
      name: '',
      password: ''
    }
  }),
  computed: mapGetters(["userData", "userId"]),
  methods: {
    ...mapActions(["newManager"]),
    onSubmit () {
      this.form.userId = this.userId
      if (this.form.name && this.form.password) {
        this.newManager(this.form)
      } else {
        alert('入力項目をご確認ください')
      }
    }
  }
}
</script>