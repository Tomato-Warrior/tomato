<template>
  <div>
    <form action="#">
  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input type="text" class="form-control" name="" aria-describedby="emailHelp" placeholder="Enter email"  v-model="task.title">
  
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input type="password" class="form-control" placeholder="Password">
  </div>
  <div class="form-group form-check">
    <input type="checkbox" class="form-check-input" >
    <label class="form-check-label" for="exampleCheck1">Check me out</label>
  </div>
      <input type="submit" value="Submit" @click="updateTask">
    </form> 
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import Rails from '@rails/ujs';

export default {
  name: 'TaskEdit',
  props: ['task', 'show'],
  data: function() {
    return {
      // task: {}
    }
  },
  computed: {
    ...mapState(['tasks'])
  },
  methods: {
    ...mapActions(['updatedTask']),

    updateTask: function(evt) {
      evt.preventDefault();
      // this.updatedTask(this.tasks[0].id); // state是陣列
    }
  },
}
</script>