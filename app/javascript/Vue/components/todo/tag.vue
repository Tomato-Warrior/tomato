<template>
  <span class="badge tag-color mx-1 py-1 px-2">{{ tag }}</span>
</template>

<script>
export default {
  name: 'TaskTag',
  props: ['tag']
}
</script>
