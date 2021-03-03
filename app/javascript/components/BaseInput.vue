<template>
  <div>
    <v-text-field
      v-if="type === 'text' || type === 'email'"
      v-model="inputValue"
      :label="label"
      :rules="rule"
      :counter="type === 'email' ? null : 30"
      @blur="onBlur"
    ></v-text-field>

    <v-textarea
      v-if="type === 'textarea' || type === 'middle'"
      v-model="inputValue"
      :label="label"
      :rules="rule"
      :counter="textareaCounter"
      @blur="onBlur"
    ></v-textarea>

    <v-text-field
      v-if="type === 'password'"
      v-model="inputValue"
      :label="label"
      :append-icon="appendIcon ? 'mdi-eye' : 'mdi-eye-off'"
      :type="appendIcon ? 'text' : 'password'"
      :rules="rule"
      @click:append="appendIcon = !appendIcon"
      @blur="onBlur"
    ></v-text-field>

    <v-select
      v-if="type === 'select'"
      v-model="inputValue"
      :multiple="multiple"
      :hint="multiple ? '複数選択可' : ''"
      :label="label"
      :items="items"
      :rules="requires"
      :disabled="disabled"
      @blur="onBlur"
    ></v-select>

    <v-checkbox
      v-if="type === 'checkbox'"
      v-model="inputValue"
      :label="label"
      @click="onBlur"
    ></v-checkbox>
  </div>
</template>

<script>
export default {
  props: {
    label: String,
    type: {
      type: String,
      default: 'text'
    },
    items: Array,
    defaultValue: String,
    multiple: {
      type: Boolean,
      default: false
    },
    value: {
      default: null
    },
    before: {
      type: Boolean,
      default: false
    },
    disabled: Boolean
  },
  mounted () {
    if (this.before) {
      this.inputValue = this.value
    }
  },
  data: () => ({
    requires: [ v => !!v || '必須項目です' ],
    max30:    [ v => !!v && v.length <= 30 || '30文字以下で入力してください' ],
    max500:   [ v => !!v && v.length <= 500 || '500字以下で入力してください' ],
    max3000:  [ v => !!v && v.length <= 3000 || '3000文字以下で入力してください' ],
    email:    [ v => /.+@.+/.test(v) || 'メールアドレスの形式が正しくありません' ],
    password: [ v => !!v && v.length >= 8 || '8文字以上で設定してください' ],
    appendIcon: false,
    inputValue: null
  }),
  computed: {
    rule () {
      switch (this.type) {
        case ('email'):
          return this.email
        case ('middle'):
          return this.max500
        case ('textarea'):
          return this.max3000
        case ('password'):
          return this.password.concat(this.max30)
        default:
          return this.requires.concat(this.max30)
      }
    },
    textareaCounter () {
      if (this.type === 'middle') {
        return 500
      } else {
        return 3000
      }
    }
  },
  watch: {
    value () {
      this.inputValue = this.value
    }
  },
  methods: {
    onBlur () {
      this.$emit('input', this.inputValue)
    }
  }
}
</script>