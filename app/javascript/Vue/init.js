import Vue from 'vue/dist/vue.esm'
import App from './components/app.vue'
import TurbolinksAdapter from 'vue-turbolinks'
import store from './components/store'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const el = document.querySelector('#app');

  if (el) {
    const app = new Vue({
      el,
      store,
      components: { App }
    })
  }
})