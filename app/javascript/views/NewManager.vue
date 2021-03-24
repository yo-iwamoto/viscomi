<template>
  <v-stepper v-model="s" class="pt-5">
    <h1 id="form-title">公民館管理者登録</h1>
    <v-stepper-items>
      <v-stepper-content step="1">
        <v-form class="form" ref="user_data_form" @submit.prevent>
          <base-input
            label="名前（ニックネーム）"
            @input="userForm.name = $event" />
          <base-input
            label="メールアドレス"
            type="email"
            @input="userForm.email = $event" />
          <base-input
            label="パスワード"
            type="password"
            @input="userForm.password = $event" />
          <base-alert :showAlert="showAlert" comment="パスワードが一致しません。" />
          <base-input
            label="パスワード再入力"
            type="password"
            @input="password_conf = $event" />
          <base-button value="次へ" @click="checkUserData" />
        </v-form>
      </v-stepper-content>
      <v-stepper-content step="2">
        <v-form class="form" ref="manager_data_form" @submit.prevent>
          <base-input
            label="公民館の名称"
            @input="managerForm.name = $event" />
          <base-input
            label="登録用パスワード"
            type="password"
            @input="managerForm.password = $event" />
          <base-button value="登録" @click="onSubmit" />
          <p @click="s = 1" class="blue--text my-5">戻る</p>
        </v-form>
      </v-stepper-content>
    </v-stepper-items>
  </v-stepper>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data: () => ({
    userForm: {
      name: '',
      email: '',
      password: ''
    },
    managerForm: {
      name: '',
      password: ''
    },
    showAlert: false,
    password_conf: '',
    s: 1
  }),
  methods: {
    ...mapActions(["newManager"]),
    checkUserData () {
      if (this.userForm.password !== this.password_conf) {
        this.showAlert = true
      } else if (this.$refs.user_data_form.validate()) {
        this.s = 2
      }
    },
    onSubmit () {
      if (this.$refs.manager_data_form.validate()) {
        this.newManager({
          userData: this.userForm,
          managerData: this.managerForm
        })
      }
    }
  }
}
</script>