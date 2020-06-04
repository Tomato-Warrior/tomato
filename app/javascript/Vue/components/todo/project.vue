<template>
  <div class="project_cover d-flex align-items-center pl-3">
    <div id="project_cover" class="project_color" :style="`background-color:${project.cover}`"></div>
    <h2 class="py-2 project-title">{{ project.title }}</h2>
  </div>
</template>

<script>
import { mapState } from 'vuex'
export default {
  name: 'TaskProject',
  props: ['project'],
}
</script>