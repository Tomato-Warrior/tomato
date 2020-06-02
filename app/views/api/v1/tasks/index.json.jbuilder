# json.array! @task, partial: 'api/v1/vue/tasks/task', as: :task  
json.array! @task do |task|
  json.id task.id
  json.tags task.tag_items
  json.expect_tictac task.expect_tictacs
  json.finish_tictac task.tictacs.finished.count
  json.cancel_tictac task.tictacs.cancelled.count

end