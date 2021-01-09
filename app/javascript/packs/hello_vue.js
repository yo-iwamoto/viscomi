import Vue     from 'vue'
import App     from '../views/App.vue'
import vuetify from '../plugins/vuetify'
import router  from '../router'
import store   from '../plugins/store'

import { globalMixins } from '../mixins/set_title'
Vue.mixin(globalMixins)

require('../stylesheets/styles.scss')

store.dispatch('autoLogin')

Vue.config.productionTip = false

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    vuetify,
    router,
    store,
    render: h => h(App)
  }).$mount();
  document.body.appendChild(app.$el)
})