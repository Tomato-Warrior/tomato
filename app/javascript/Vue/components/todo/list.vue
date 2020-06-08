<template>
  <div class="px-2 task-hover project-task-list d-flex flex-nowrap" :data-task-id="task.id">
    <div class="d-flex align-items-center">
      <a href="#" @click="markComleted" class="pl-4 play-icon">
        <svg v-show="task.status === 'doing'" class="svg-inline--fa fa-circle fa-w-16" aria-hidden="true" focusable="false" data-prefix="far" data-icon="circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm0 448c-110.5 0-200-89.5-200-200S145.5 56 256 56s200 89.5 200 200-89.5 200-200 200z"></path></svg>
        <svg v-show="task.status === 'done'"  class="svg-inline--fa fa-check-circle fa-w-16 icon" aria-hidden="true" focusable="false" data-prefix="far" data-icon="check-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" data-fa-i2svg=""><path fill="currentColor" d="M256 8C119.033 8 8 119.033 8 256s111.033 248 248 248 248-111.033 248-248S392.967 8 256 8zm0 48c110.532 0 200 89.451 200 200 0 110.532-89.451 200-200 200-110.532 0-200-89.451-200-200 0-110.532 89.451-200 200-200m140.204 130.267l-22.536-22.718c-4.667-4.705-12.265-4.736-16.97-.068L215.346 303.697l-59.792-60.277c-4.667-4.705-12.265-4.736-16.97-.069l-22.719 22.536c-4.705 4.667-4.736 12.265-.068 16.971l90.781 91.516c4.667 4.705 12.265 4.736 16.97.068l172.589-171.204c4.704-4.668 4.734-12.266.067-16.971z"></path></svg>
      </a>
      <a :href="`/tasks/${task.id}/tictac`" class="ml-3 mr-2 play-icon"><i class="far fa-play-circle"></i></a>
    </div>
    <div class="align-items-center font-container">
      <a :href="`/projects/${task.project_id}/tasks/${task.id}`" class="list-font mx-3">{{ task.title }}</a>
      <div class="d-flex ml-1 tictac_icon">
        <div class="d-flex align-items-center ml-2"  :title="`已完成時鐘：${task.finish_tictac}`">
          <img src='/finish_tictac.png' class='task_tictac'>
          <small>{{ task.finish_tictac }}</small>
        </div>
        <div class="d-flex align-items-center ml-1"  :title="`已取消時鐘：${task.cancel_tictac}`">
          <img src='/cancel_tictac.png' class='task_tictac'>
          <small>{{ task.cancel_tictac }}</small>
        </div>
      </div>
    </div>
    <div class="info-container">

      <!-- <div class="d-flex align-items-center">
         <select :name="`${task.id}`" :id="`${task.trello_info.card_id}`" @change="trello_list">
           <%= options_for_select(list_data_trans(task, current_user.trello_token), task.trello_info.list_id) %>
         </select>
      </div>
   -->
    </div>
    <div class="d-flex align-items-center ml-auto delete-icon">
      <a :href="`/projects/${task.project_id}/tasks/${task.id}/edit`" class="mx-1">
        <i class="fas fa-pencil-alt"></i>
      </a>
      <a href="#" @click="confirmToRemoveTask" class="mx-4">
        <i class="fas fa-trash-alt"></i>
      </a>
    </div>
  </div>
</template>

<script>
import TaskTag from './tag';
import { mapActions } from 'vuex'

export default {
  name: 'TaskList',
  props: ['task'],
  methods: {
    ...mapActions(['removeTask', 'completeTask']), 
    confirmToRemoveTask: function(evt) {
      evt.preventDefault();
      
      if (confirm('確定刪除')) {
        this.removeTask(this.$el.dataset.taskId);
      }
    }, 
    markComleted: function(evt) {
      evt.preventDefault();
      this.completeTask(this.$el.dataset.taskId)
    },
  },
  components: {
    TaskTag
  }
}
</script>