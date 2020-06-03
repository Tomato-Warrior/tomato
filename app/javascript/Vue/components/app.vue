<template>
  <div>
    <TaskInput :project-id="project"/>
  </div>
</template>

<script>
  import { TaskInput, TaskGroup } from './todo';
  export default {
    name: 'App',
    data: function () {
      return {
      }
    },
    props: ['project'],
    components: {
    TaskInput,
    TaskGroup
    },
  }
</script>

<style scoped>

</style>
