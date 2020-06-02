<template>
  <div class="project_task_container mx-3 mt-4 mb-2 pt-2" >
    <TaskList/>
  </div>
</template>

<script>
import TaskList from './list';
export default {
  name: 'TaskGroup',
  data: function(){
    return {
      
    }
  },
  components: {
    TaskList
    },

}
</script>