<template>
  <div>
    <TaskInput/>
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
    components: {
    TaskInput,
    TaskGroup
    },
  }
</script>

<style scoped>

</style>
