<template>
  <div>
    <ProjectInfo :info="infoList"/>
    <TaskProject :project="projectTitle" />
    <TaskInput :project-id="project" />
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
    computed: {
      ...mapState(['projectTitle']),
      ...mapState(['infoList'])
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
