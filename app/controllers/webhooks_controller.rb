class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session

  $data
  def complete
    render status: 200
  end

  def receive
    res = JSON.parse(request.body.read)
    member_id = Webhook.new.member_id(res)
    action = Webhook.new.action(res)
    board = Webhook.new.board(res)
    user = User.find_by(trello_member_id: member_id)
    if action == "updateCard"
      card_id = Webhook.new.card(res).values_at("id").join
      @after_list = Webhook.new.after_list(res)
      target_task = user.trello_infos.where(card_id: card_id)[0].task
      byebug
      target_task.trello_info.update(list_id: @after_list[0])
    elsif action == "createCard"
      new_card = Webhook.new.card(res)
      card_position = Webhook.new.current_list(res)
      target_project = user.projects.where(title: board.values_at("name"))[0]
      new_task = target_project.tasks.create(title: new_card.values_at("name").join, user_id: user.id)
      new_task.create_trello_info({card_id:new_card.values_at("id")[0], 
                                  list_id:card_position.values_at("id")[0], 
                                  board_id:board.values_at("id")[0], 
                                  user_id: user.id})
    end
  end
end