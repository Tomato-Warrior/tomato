<template>
  <div>
    <TaskInput :project-id="project" />
    <TaskGroup />
  </div>
</template>

<script>
  import { TaskInput, TaskGroup } from './todo';
  import { mapActions } from 'vuex';

  export default {
    name: 'App',
    props: ['project'],
    methods: {
      ...mapActions(['loadTasks'])
    },
    components: {
      TaskInput,
      TaskGroup
    },
    beforeMount: function() {
      this.loadTasks(this.project);
    }
  }
</script>

<style scoped>

</style>
