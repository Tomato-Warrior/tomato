json.project do
  json.id @project.id
  json.title @project.title
  json.color @project.cover
  json.finish_tictac @tictac_count
  json.expect_time @project_expect_time

  json.doingTasks do
    json.array! @tasks.doing.order(id: :desc) do |task|
      json.id task.id
      json.title task.title
      json.tags task.tag_items
      json.expect_tictac task.expect_tictacs
      json.finish_tictac task.tictacs.finished.count
      json.cancel_tictac task.tictacs.cancelled.count
      json.status task.status
      if task.trello_info
        json.trello_card task.trello_info.card_id
        json.trello_list task.trello_info.list_id
        json.trello_token current_user.trello_token
      end
    end
  end

  json.doneTasks do
    json.array! @tasks.done.order(id: :desc) do |task|
      json.id task.id
      json.title task.title
      json.tags task.tag_items
      json.expect_tictac task.expect_tictacs
      json.finish_tictac task.tictacs.finished.count
      json.cancel_tictac task.tictacs.cancelled.count
      json.status task.status
    end
  end
end