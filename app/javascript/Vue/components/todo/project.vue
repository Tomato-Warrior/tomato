<template>
  <div class="project_cover d-flex align-items-center pl-3">
    <div id="project_cover" class="project_color" :style="`background-color:${ color }`"></div>
    <h2 class="py-2 project-title">{{ projectTitle }}</h2>
    <div class="ml-auto mr-4 submit-radius p-2" v-if="trello_board != null" >
      <a :href="`/projects/${projectId}/chart`" class="text-light">Trello報表</a>
    </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  name: 'TaskProject',
  computed: {
    ...mapState(['projectTitle', 'color', 'projectId', 'trello_board'])
  }
}
</script>