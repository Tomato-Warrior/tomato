json.all_projects current_user.projects.pluck(:id, :title)

json.project do
  json.id @project.id
  json.title @project.title
  json.color @project.cover
  json.finish_tictac @tictac_count
  json.expect_time @project_expect_time
  json.tasks do
    
    json.array! @tasks.order(id: :desc) do |task|
      json.id task.id
      json.title task.title
      json.tags task.tag_items
      json.expect_tictac task.expect_tictacs
      # json.project_id current_user.projects.ids
      json.date task.date
      json.description task.description
      if task.trello_info
        json.trello_card task.trello_info.card_id
        json.trello_list task.trello_info.list_id
        json.trello_token current_user.trello_token
        json.trell0_board task.trello_info.board_id
      end
    end
  end

  json.doingTasks do
    json.array! @tasks.doing.order(id: :desc) do |task|
      json.id task.id
      json.title task.title
      json.tags task.tag_items
      json.expect_tictac task.expect_tictacs
      json.finish_tictac task.tictacs.finished.count
      json.cancel_tictac task.tictacs.cancelled.count
      json.status task.status
      json.project_id task.project_id
      json.date task.date.strftime("%Y-%m-%d")

      if task.trello_info
        json.trello_card task.trello_info.card_id
        json.trello_list task.trello_info.list_id
        json.trello_token current_user.trello_token
        json.trell0_board task.trello_info.board_id
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
      json.project_id task.project_id
      json.date task.date
      if task.trello_info
        json.trello_card task.trello_info.card_id
        json.trello_list task.trello_info.list_id
        json.trello_token current_user.trello_token
        json.trell0_board task.trello_info.board_id
      end
    end
  end
end