<template>
  <div>
    <form action="#">
      <div class="form-group">
        <label>任務名稱</label>
        <input type="text" class="form-control" v-model="task.title">
      </div>
      <div class="form-group">
        <label>Tag</label>
        <select class="form-control tag-select2" multiple="multiple">
          <option v-for="project in task.project_id">
            {{ project }}
          </option>
        </select>
      </div>
      <div class="form-group">
        <label>Tag</label>
        <select class="form-control tag-select2" multiple="multiple">
          <option v-for="tag in task.tags">
            {{ tag }}
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
        <label>任務執行日期</label>
        <input type="date" class="form-control" v-model="task.expect_date">
      </div>
      <input type="submit" value="Submit" @click="updateTask">
    </form> 
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import Rails from '@rails/ujs';

export default {
  name: 'TaskEdit',
  props: ['task', 'show'],
  data: function() {
    return {
    }
  },
  computed: {
    ...mapState(['tasks'])
  },
  methods: {
    ...mapActions(['updatedTask']),

    updateTask: function(evt) {
      evt.preventDefault();
      // this.updatedTask(this.tasks[0].id); // state是陣列
    }
  },
}
</script>