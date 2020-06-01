import Vue from 'vue/dist/vue.esm'
import App from './components/app.vue'
import TurbolinksAdapter from 'vue-turbolinks'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const el = document.querySelector('#app');

  if (el) {
      const app = new Vue({
          el,
          data: () => {
              return { }
          },
          components: { App }
      })
  }
})