import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
import Rails from '@rails/ujs';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    doingTasks: [], 
    doneTasks: [],
    projectTitle: [],
    infoList: [],
  },

  mutations: {
    ADD_TASK(state, resp){
      state.doingTasks.unshift(resp.task);
    },

    TOGGLE_COMPLETE(state, resp) {
      let taskId = resp.task.id;
      let status = resp.task.status;
      let fromTasks = (status == 'done') ? state.doingTasks : state.doneTasks;
      let toTasks = (status == 'done') ? state.doneTasks : state.doingTasks;

      let foundTask = fromTasks.findIndex(task => task.id == taskId);
      
      if (foundTask >= 0) {
        let removedTask = fromTasks.splice(foundTask, 1);
        toTasks.unshift(removedTask[0]);
      }
    }, 

    SET_TASKS(state, resp){
      state.doingTasks = resp.doingTasks;
      state.doneTasks = resp.doneTasks;
      state.projectTitle = resp.projectTitle;
      state.infoList = resp.infoList;
    }, 

    REMOVE_TASK(state, resp) {
      let taskId = resp.task.id;
      let targetTasks = (resp.task.status == 'doing') ?  state.doingTasks : state.doneTasks;

      let foundTask = targetTasks.findIndex(task => task.id == taskId);
      
      if (foundTask >= 0) {
        targetTasks.splice(foundTask, 1);
      }
    }
  }, 

  actions: {
    addTask({ commit }, {projectId, content}){

      const data = new FormData();
      data.append('task[title]', content);
      data.append('task[project_id]', projectId);

      Rails.ajax({
        url: `/api/v1/projects/${projectId}/tasks`, 
        type: 'POST', 
        data,
        dataType: 'json',
        success: resp => {
          commit('ADD_TASK', resp)
        }, 
        error: err => {
          console.log(err);
        } 
      });
    },

    completeTask({ commit }, taskId) {
      Rails.ajax({
        url: `/api/v1/tasks/${taskId}/toggle_status`,
        type: 'PATCH',
        dataType: 'JSON',
        success: resp => {
          commit('TOGGLE_COMPLETE', resp)
        },
        error: err => {
          console.log(err);          
        }
      })
    },

    removeTask({ commit }, taskId) {
      Rails.ajax({
        url: `/api/v1/tasks/${taskId}`, 
        type: 'DELETE', 
        dataType: 'JSON', 
        success: resp => {
          commit('REMOVE_TASK', resp);
        }, 
        error: err => {
          console.log(err);
        }
      })
    },

    loadTasks({ commit }, projectId) {
      Rails.ajax({
        url: `/api/v1/projects/${projectId}/tasks`, 
        type: 'GET', 
        dataType: 'json',
        success: resp => { 
          commit('SET_TASKS', resp)
        }, 
        error: err => {
          console.log(err);
        } 
      });
    }
  }
})

export default store;