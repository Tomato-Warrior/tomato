<template>
  <div>
    <div class="project_task_container mx-3 mt-4 mb-2 pt-2" >
    <TaskList v-for="task in doingTasks" :key="task.id" :task="task" />
    </div>
    <div>  
      <button class="btn done-task ml-3" type="button" data-toggle="collapse" data-target="#collapseTaskDone" aria-expanded="false" aria-controls="collapseTaskDone">
        <i class="fas fa-caret-down"></i> 顯示已完成任務
      </button>
    </div>
    <div class="collapse" id="collapseTaskDone">
      <div class="project_task_container mx-3 mt-2 mb-4 task-done">
        <TaskList v-for="task in doneTasks" :key="task.id" :task="task" />
      </div>
    </div>
  </div>

</template>

<script>
import TaskList from './list';
import { mapState } from 'vuex';

export default {
  name: 'TaskGroup',
  computed: {
    ...mapState(['doingTasks', 'doneTasks'])
  },
  components: {
    TaskList
  }
}
</script>