<template>
  <span class="tag">{{ tag }}</span>
</template>

<script>
export default {
  name: 'TaskTag',
  props: ['tag']
}
</script>

<style scoped>
.tag {
  background-color: aquamarine;
  margin: 2px;
}
</style>