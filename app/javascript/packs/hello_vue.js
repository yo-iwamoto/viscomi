import Vue from 'vue'
import App from '../App.vue'
import vuetify from '../plugins/vuetify.js'
import router from '../plugins/router.js'
import store from '../plugins/store.js'

require('../stylesheets/styles.scss')

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    vuetify,
    router,
    store,
    render: h => h(App)
  }).$mount();
  document.body.appendChild(app.$el)
})