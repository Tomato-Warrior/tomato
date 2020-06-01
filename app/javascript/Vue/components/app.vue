<template>
  <div>
    <TaskInput/>
  </div>
</template>

<script>
  import { TaskInput } from './todo';
  export default {
    name: 'App',
    data: function () {
      return {
      }
    },
    components: {
    TaskInput
    },
  }
</script>

<style scoped>

</style>
