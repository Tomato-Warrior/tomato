import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    tasks: []
  },

  mutations: {
  }, 

  actions: {
    loadTasks() {
      console.log('loading...');
    }
  }, 

  getters: {

  }
})

export default store;