<template>
  <div class="show-data mx-3 my-3">
    <h3>任務資訊</h3>
    <div class="data-container d-flex flex-wrap">
      <div class="col-6 col-md-3">
        <div class="data">
          <p>預計時間</p>
          <div class="">
            <span class="tomato-num">{{ expect_time }}</span>
            <small>小時</small>
          </div>
        </div>
      </div>
      <div class="col-6 col-md-3">
        <div class="data">
          <p>待完成任務</p>
          <div>
            <span class="doing-task-num">{{ doingTasks.length }}</span>
            <small>個</small>
          </div>
        </div>
      </div>
      <div class="col-6 col-md-3">
        <div class="data">
          <p>收集番茄</p>
          <div class="">
            <span class="tomato-num">{{ finish_tictac }}</span>
            <small>個</small>
          </div>
        </div>
      </div>
      <div class="col-6 col-md-3">
        <div class="data">
          <p>已完成任務</p>
          <div>
            <span class="done-data-num">{{ doneTasks.length }}</span>
            <small>個</small>
          </div>
        </div>
      </div>
      </div>
  </div>
</template>

<script>
import { mapState } from 'vuex';

export default {
  name: 'ProjectInfo',
  computed: {
    ...mapState(['doingTasks', 'doneTasks', 'expect_time', 'finish_tictac'])
  }
}
</script>