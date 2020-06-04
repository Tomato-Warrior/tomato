<template>
  <div class="add_task">
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="basic-addon1">
          <span class="icon-circle ml-3"><i class="fas fa-plus"></i>
          </span>
          </span>
      </div>
      <input type="text" class='form-control' placeholder="建立任務給自己一個目標吧 !" v-model.trim="content" @keydown.enter="submit" />
      <div class="input-group-append btn-submit">
        <button class="btn" @click="submit">送出</button>
      </div>
    </div>
  </div>
</template>

<script>
import Rails from '@rails/ujs'
import { mapActions } from 'vuex';

export default {
  name: 'TaskInput',
  data: function(){
    return {
      content: ''
    }
  },
  props: ['projectId'],
  methods: {
    ...mapActions(['addTask']),

    submit: function () {
      if(this.content.length != 0){
        this.addTask({projectId:this.projectId, content: this.content});
        this.content = '';
      }
    }
  },

}
</script>