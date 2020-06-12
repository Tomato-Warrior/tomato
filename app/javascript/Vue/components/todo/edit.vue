<template>
  <div>
    <form action="#">
      <div class="form-group">
        <label>任務名稱</label>
        <input type="text" class="form-control" v-model="task.title">
      </div>
      <div class="form-group" v-if="trello_board != null">
        <label>Trello</label>
        <select class="form-control" v-model="trello_selected">
          <option v-for="list in all_trello_lists" :value="list[1]">
            {{ list[0] }}
          </option>
        </select>
      </div>
      <div class="form-group" v-else>
        <label>專案</label>
        <select class="form-control" v-model="project_selected">
          <option v-for="project in projects" :value="project[0]">
            {{ project[1] }}
          </option>
        </select>
      </div>
      <div class="form-group">
        <label>預計番茄數</label>
        <input type="number" class="form-control" v-model="task.expect_tictac" min="0" >
      </div>
      <div class="form-group">
        <label>標籤</label>
        <Select2 v-model="task.tags" :options="task.tags" :settings="{ tags: 'true', multiple: 'true', tokenSeparators: [',', ' ']}" />
      </div>
      <div class="form-group">
        <label>備註</label>
        <textarea type="number" class="form-control" v-model="task.description" ></textarea>
      </div>
      <div class="form-group">
        <label>任務期限</label>
        <input type="date" class="form-control" v-model="task.date">
      </div>
      <input type="submit" value="更新" @click="updateTask" class="py-2 px-4 btn-login-submit submit-radius">
       <a href="#" @click="confirmToRemoveTask" class="delete-confirm py-2 px-4 btn-login-submit submit-radius">刪除任務</a>
    </form> 
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import Rails from '@rails/ujs';
import Select2 from 'v-select2-component';

export default {
  name: 'TaskEdit',
  props: ['show', 'task'],
  data: function() {
    return {
      selectedProjectId: (this.task.project_id), 
      selectedTrelloId:(this.task.trello_list),
      tags: ''
    }
  },
  computed: {
    ...mapState(['projects', 'all_trello_lists', 'trello_board']), 
    project_selected: {
      get: function() {
        return this.task.project_id;
      }, 
      set: function(newValue) {
        this.selectedProjectId = newValue;
      }
    },
    trello_selected: {
      get: function() {
        return this.task.trello_list;
      }, 
      set: function(newValue) {
        this.selectedTrelloId = newValue;
      }
    }
  },
  components: {
    Select2
  },
  methods: {
    ...mapActions(['updatedTask', 'removeTask']),

    confirmToRemoveTask: function(evt) {
      evt.preventDefault();
      if (confirm('確定刪除')) {
        this.removeTask(this.task.id);
      }
    $('.delete-confirm').modal('hide');
    }, 

    updateTask: function(evt) {
      evt.preventDefault();
      this.updatedTask({ 
        taskId: this.task.id, 
        taskTitle: this.task.title,
        taskDate: this.task.date, 
        expectTictac: this.task.expect_tictac, 
        taskDesc: this.task.description, 
        taskTag: this.task.tags, 
        selectedProjectId: this.selectedProjectId,
        trelloList: this.selectedTrelloId
      });

      $(`#editVueTask-${this.task.id}`).modal('hide');
    },

  },
  
}
</script>