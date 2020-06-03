<template>
  <div class="project_task_container mx-3 mt-4 mb-2 pt-2" >
    <TaskList v-for="task in doingTasks" :key="task.id" :task="task" />
  </div>
</template>

<script>
import TaskList from './list';
import { mapState } from 'vuex';

export default {
  name: 'TaskGroup',
  data: function(){
    return {
      
    }
  },
  computed: {
    ...mapState(['doingTasks', 'doneTasks'])
  },
  components: {
    TaskList
  }
}
</script>