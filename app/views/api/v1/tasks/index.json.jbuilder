json.projectTitle do
  json.array! @task.doing do |task|
    json.title task.project.title
    json.cover task.project.cover
  end
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
  end
end