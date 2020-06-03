<template>
  <div class="p-2 task-hover project-task-list d-flex flex-nowrap">
    <div class="d-flex align-items-center">
      <a href="#" class="pl-4 play-icon"><i class="far fa-circle"></i></a>
      <a href="#" class="ml-3 mr-2 play-icon"><i class="far fa-play-circle"></i></a>
    </div>
    <div class="d-flex align-items-center">
      <a href="#" class="list-font mx-3">{{ task.title }}</a>
    </div>
    <div class="d-flex align-items-center ml-2"  title="已完成時鐘：<%= task.tictacs.finished.count %>">
      <img src='/finish_tictac.png' class='task_tictac'>
      <small>{{ task.finish_tictac }}</small>
    </div>
    <div class="d-flex align-items-center ml-2"  title="取消時鐘：<%= task.tictacs.cancelled.count %>">
      <img src='/cancel_tictac.png' class='task_tictac'>
      <small>{{ task.cancel_tictac }}</small>
    </div>
    <div class="d-flex align-items-center text-right tag-icon ml-4">
      <TaskTag v-for="tag in task.tags" :tag="tag" :key="tag" />
    </div>
    <div class="d-flex align-items-center text-right delete-icon">
      <a href="#" class="mx-1"><i class="fas fa-pencil-alt"></i></a>
      <a href="#" method="delete" class="mx-4"><i class="fas fa-trash-alt"></i></a>
    </div>
  </div>
</template>

<script>
import TaskTag from './tag';

export default {
  name: 'TaskList',
  props: ['task'],
  components: {
    TaskTag
  }
}
</script>