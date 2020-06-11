import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
import Rails from '@rails/ujs';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    doingTasks: [], 
    doneTasks: [],
    projectTitle: '',
    color: '#ffffff', 
    expect_time: '', 
    finish_tictac: 0, 
    projectId: 0,
    loaded: false,
    projects: []
  },

  mutations: {
    ADD_TASK(state, resp){
      state.doingTasks.unshift(resp.task);
    },

    UPDATE_TASK(state, resp){
      // let taskId = resp.task.id
    },

    TOGGLE_COMPLETE(state, resp) {
      let taskId = resp.task.id;
      let status = resp.task.status;
      let fromTasks = (status == 'done') ? state.doingTasks : state.doneTasks;
      let toTasks = (status == 'done') ? state.doneTasks : state.doingTasks;

      let foundTask = fromTasks.findIndex(task => task.id == taskId);

      if (foundTask >= 0) {
        let removedTask = fromTasks.splice(foundTask, 1)[0];
        toTasks.unshift(removedTask);

        let increase_time = Math.round((state.expect_time - (removedTask.expect_tictac * 1500 / 3600))*10)/10;
        let decrease_time = Math.round((state.expect_time + (removedTask.expect_tictac * 1500 / 3600))*10)/10;

        if (removedTask.status == 'doing'){
          removedTask.status = 'done';
          state.expect_time = ( increase_time >= 0) ? increase_time : 0;
        }else{
          removedTask.status = 'doing';
          state.expect_time = ( decrease_time >= 0) ? decrease_time : 0;
        }  
      }
    }, 

    SET_TASKS(state, resp){
      const project = resp.project;
      state.doingTasks = project.doingTasks;
      state.doneTasks = project.doneTasks;
      state.tasks = project.tasks;
      state.projectTitle = project.title;
      state.color = project.color;
      state.expect_time = project.expect_time;
      state.finish_tictac = project.finish_tictac;
      state.projectId = project.id;
      state.projects = resp.all_projects;
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

    updatedTask({ commit }, {taskId, taskTitle, taskDate, expectTictac, taskDesc, taskTag, selectedProjectId}){

      const data = new FormData();
      data.append('task[title]', taskTitle);
      data.append('task[date]', taskDate);
      data.append('task[expect_tictacs]', expectTictac);
      data.append('task[description]', taskDesc);
      data.append('task[tag_items][]', taskTag); 
      data.append('task[project_id]', selectedProjectId);

      Rails.ajax({
        url: `/api/v1/tasks/${taskId}`,
        type: 'PATCH',
        dataType: 'JSON',
        data,
        success: resp => {
          commit('UPDATE_TASK', resp)
        },
        error: err => {
          console.log(err);          
        }
      })
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

    loadTasks({ commit, state }, projectId) {
      state.loaded = false;
      Rails.ajax({
        url: `/api/v1/projects/${projectId}/tasks`, 
        type: 'GET', 
        dataType: 'json',
        success: resp => { 
          commit('SET_TASKS', resp);
          state.loaded = true;
        }, 
        error: err => {
          console.log(err);
        } 
      });
    }
  }
})

export default store;