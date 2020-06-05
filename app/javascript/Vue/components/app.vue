<template>
  <div>
    <ProjectInfo />
    <TaskProject />
    <TaskInput />
    <TaskGroup />
  </div>
</template>

<script>
  import { TaskInput, TaskGroup, TaskProject, ProjectInfo } from './todo';
  import { mapActions, mapState } from 'vuex';

  export default {
    name: 'App',
    props: ['project'],
    methods: {
      ...mapActions(['loadTasks']),
    },
    components: {
      TaskInput,
      TaskGroup,
      TaskProject,
      ProjectInfo
    },
    beforeMount: function() {
      this.loadTasks(this.project);
    }
  }
</script>

<style scoped>

</style>
