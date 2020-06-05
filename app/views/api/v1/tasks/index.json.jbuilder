json.projectTitle do
  json.title @project.title
  json.cover @project.cover
end
json.infoList do
  json.fin_tictac @tictac_count
  json.expect_time @project_expect_time
end
json.doingTasks do
  json.array! @task.doing do |task|
    json.id task.id
    json.title task.title
    json.tags task.tag_items
    json.expect_tictac task.expect_tictacs
    json.finish_tictac task.tictacs.finished.count
    json.cancel_tictac task.tictacs.cancelled.count
    json.project_id task.project_id
    json.status task.status
  end
end
json.doneTasks do
  json.array! @task.done do |task|
    json.id task.id
    json.title task.title
    json.tags task.tag_items
    json.expect_tictac task.expect_tictacs
    json.finish_tictac task.tictacs.finished.count
    json.cancel_tictac task.tictacs.cancelled.count
    json.project_id task.project_id
    json.status task.status
  end
end
json.doing_today_task do
  json.array! @today_tasks.doing do |task|
    json.id task.id
    json.title task.title
    json.tags task.tag_items
    json.expect_tictac task.expect_tictacs
    json.finish_tictac task.tictacs.finished.count
    json.cancel_tictac task.tictacs.cancelled.count
    json.project_id task.project_id
    json.status task.status
  end
end
json.done_today_task do
  json.array! @today_tasks.done do |task|
    json.id task.id
    json.title task.title
    json.tags task.tag_items
    json.expect_tictac task.expect_tictacs
    json.finish_tictac task.tictacs.finished.count
    json.cancel_tictac task.tictacs.cancelled.count
    json.project_id task.project_id
    json.status task.status
  end
end