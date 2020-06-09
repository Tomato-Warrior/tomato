<template>
  <div>
    <form action="#">
      <div class="form-group">
        <label>任務名稱</label>
        <input type="text" class="form-control" v-model="task.title">
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
import Select from "select2-vue-component";

export default {
  name: 'TaskEdit',
  props: ['task', 'show'],
  data: function() {
    return {
    }
  },
  methods: {
    ...mapActions(['updatedTask']),

    updateTask: function(evt) {
      evt.preventDefault();
      this.updatedTask({ taskId: this.task.id, taskTitle: this.task.title });
      // ,taskDate: this.task.date, expectTictac: this.task.expect_tictac, taskDesc: this.task.description
    }
  },
  
}
</script>