import Vue     from 'vue'
import App     from '../views/App.vue'
import vuetify from '../plugins/vuetify'
import router  from '../router'
import store   from '../store/index'

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
      .then(function(registration) {
        console.log("serviceWorker registed.")
      }).catch(function(error) {
        console.warn("serviceWorker error.", error)
      })
  }
})

require('../stylesheets/styles.scss')

store.dispatch('autoLogin')

Vue.config.productionTip = false

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    data: () => ({
      m: 'helo'
    }),
    vuetify,
    router,
    store,
    render: h => h(App)
  }).$mount();
  document.body.appendChild(app.$el)
})