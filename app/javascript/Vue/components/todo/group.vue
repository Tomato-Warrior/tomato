<template>
  <div class="project_task_container mx-3 mt-4 mb-2 pt-2" >
    <TaskList v-for="task in tasks" :key="task.id" :task="task" />
  </div>
</template>

<script>
import TaskList from './list';
import { mapGetters } from 'vuex';

export default {
  name: 'TaskGroup',
  data: function(){
    return {
      
    }
  },
  computed: {
    ...mapGetters(['tasks'])
  },
  components: {
    TaskList
  }
}
</script>