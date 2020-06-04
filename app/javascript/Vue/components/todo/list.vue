<template>
  <div class="p-2 task-hover project-task-list d-flex flex-nowrap" :data-task-id="task.id">
    <div class="d-flex align-items-center">
      <a href="#" @click="markComleted" class="pl-4 play-icon"><i class="far fa-circle"></i></a>
      <a :href="`/tasks/${task.id }/tictac`" class="ml-3 mr-2 play-icon"><i class="far fa-play-circle"></i></a>
    </div>
    <div class="d-flex align-items-center">
      <a :href="`/projects/${task.project_id}/tasks/${task.id}`" class="list-font mx-3">{{ task.title }}</a>
    </div>
    <div class="d-flex align-items-center ml-2"  :title="`已完成時鐘：${task.finish_tictac}`">
      <img src='/finish_tictac.png' class='task_tictac'>
      <small>{{ task.finish_tictac }}</small>
    </div>
    <div class="d-flex align-items-center ml-2"  :title="`${task.cancel_tictac}`">
      <img src='/cancel_tictac.png' class='task_tictac'>
      <small>{{ task.cancel_tictac }}</small>
    </div>
    <div class="d-flex align-items-center text-right tag-icon ml-4">
      <TaskTag v-for="tag in task.tags" :tag="tag" :key="tag" />
    </div>
    <div class="d-flex align-items-center text-right delete-icon">
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
      
      if (confirm('confirm to delete?!')) {
        this.removeTask(this.$el.dataset.taskId);
      }
    }, 
    markComleted: function(evt) {
      evt.preventDefault();
      this.completeTask(this.$el.dataset.taskId)
    }
  },
  components: {
    TaskTag
  }
}
</script>