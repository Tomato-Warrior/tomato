<template>
  <div>
    <form action="#">
      <div class="form-group">
        <label>任務名稱</label>
        <input type="text" class="form-control" v-model="task.title">
      </div>
      <div class="form-group">
        <label>專案</label>
        <select class="form-control" v-model="selected">
          <option v-for="project in projects" :value="project[0]">
            {{ project[1] }}
          </option>
        </select>
      </div>
      <div class="form-group">
        <label>預計番茄鐘</label>
        <input type="number" class="form-control" v-model="task.expect_tictac" min="0" >
      </div>
      <div class="form-group">
        <label>任務筆記</label>
        <textarea type="number" class="form-control" v-model="task.description" ></textarea>
      </div>
      <div class="form-group">
        <Select2 v-model="task.tags" :options="task.tags" :settings="{ tags: 'true', multiple: 'true', tokenSeparators: [',', ' ']}" />
      </div>
      <div class="form-group">
        <label>任務執行日期</label>
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
      tags: ''
    }
  },
  computed: {
    ...mapState(['projects']), 
    selected: {
      get: function() {
        return this.task.project_id;
      }, 
      set: function(newValue) {
        this.selectedProjectId = newValue;
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
        selectedProjectId: this.selectedProjectId
      });

      $(`#editVueTask-${this.task.id}`).modal('hide');
    },

  },
  
}
</script>