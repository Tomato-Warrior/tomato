<template>
  <div v-show="show">
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
    data: function(){
      return {
        show: false
      };
    },
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
    },
    mounted: function() {
      this.show = true
    }
  }
</script>

<style scoped>

</style>
