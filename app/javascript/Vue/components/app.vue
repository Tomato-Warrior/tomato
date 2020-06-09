<template>
  <div>
    <div v-if="loaded">
      <ProjectInfo />
      <TaskProject />
      <TaskInput />
      <TaskGroup />
    </div>
    <div v-else>
      Loading
    </div>
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
    computed: {
      ...mapState(['loaded']),
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
