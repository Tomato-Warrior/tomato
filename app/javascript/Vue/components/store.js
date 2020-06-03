import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
import Rails from '@rails/ujs';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    tasks: []
  },

  mutations: {
    SET_TASKS(state, tasks){
      state.tasks = tasks;
    }
  }, 

  actions: {
    loadTasks({ commit }, projectId) {
      
      Rails.ajax({
        url: `/api/v1/projects/${projectId}/tasks`, 
        type: 'GET', 
        dataType: 'json',
        success: resp => {
          commit('SET_TASKS', resp.tasks)
        }, 
        error: err => {
          console.log(err);
        } 
      });
    }
  }, 

  getters: {

  }
})

export default store;