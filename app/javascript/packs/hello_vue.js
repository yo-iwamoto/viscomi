import Vue from 'vue'
import App from '../views/App.vue'
import vuetify from '../plugins/vuetify.js'
import router from '../router.js'
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