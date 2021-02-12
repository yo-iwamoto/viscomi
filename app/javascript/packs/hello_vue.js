import Vue     from 'vue'
import App     from '../views/App.vue'
import vuetify from '../plugins/vuetify'
import router  from '../router'
import store   from '../store/index'

import VueScrollTo from 'vue-scrollto'
Vue.use(VueScrollTo)

import axios   from '../plugins/axios'
Vue.prototype.$axios = axios

// componentsの一括登録
const pascal2ComponentName = (fileName) => {
  const temp = pascal2camel(fileName)
  return temp[0].toUpperCase() + temp.substr(1)
}

const pascal2camel = (fileName) => {
  return fileName
    .split('/')
    .pop()
    .replace(/-(\w)/g, (_all, w) => w.toUpperCase())
    .replace(/\.\w+$/, '') // ファイル拡張子は不要
}
const requireComponent = require.context('../components', true, /.*\.vue/)
requireComponent.keys().forEach((fileName) => {
  const component = requireComponent(fileName)
  const componentName = pascal2ComponentName(fileName)
  Vue.component(componentName, component.default || component)
})

window.addEventListener('load', function() {
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register("/serviceWorker.js")
  }
})

require('../stylesheets/styles.scss')

store.dispatch('autoLogin')

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    el,
    vuetify,
    router,
    store,
    render: h => h(App)
  }).$mount();
})