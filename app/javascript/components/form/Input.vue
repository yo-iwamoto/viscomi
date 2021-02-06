<template>
  <div>
    <v-text-field
      v-if="type === 'text'"
      v-model="inputValue"
      :label="label"
      :rules="rule"
      @blur="onBlur"
    ></v-text-field>

    <v-textarea
      v-if="type === 'textarea'"
      v-model="inputValue"
      :label="label"
      :rules="rule"
      @blur="onBlur"
    ></v-textarea>

    <v-text-field
      v-if="type === 'password'"
      v-model="inputValue"
      :label="label"
      :append-icon="appendIcon ? 'mdi-eye' : 'mdi-eye-off'"
      :type="appendIcon ? 'text' : 'password'"
      :rules="requires"
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
    ruleType: String,
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
    emailRules: [
      v => !!v || '必須項目です',
      v => /.+@.+/.test(v) || 'メールアドレスの形式が正しくありません'
    ],
    appendIcon: false,
    inputValue: null
  }),
  computed: {
    rule () {
      if (this.ruleType === 'email') {
        return this.emailRules
      } else if (this.ruleType === 'noRule') {
        return
      } else {
        return this.requires
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