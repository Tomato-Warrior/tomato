class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  $response
  def complete
    render status: 200
  end

  def receive
    $response = JSON.parse(request.body.read)
    res = $response
    action = Webhook.new.action(res)
    board = Webhook.new.board(res)
    if action == "updateCard"
      card_id = Webhook.new.card(res).values_at("id").join
      @before_list = Webhook.new.before_list(res)
      @after_list = Webhook.new.after_list(res)
      @target_task = current_user.trello_infos.where(card_id: card_id)[0].task
      @target_task.trello_info.update(list_id: @after_list[0])
    elsif action == "createCard"
      #新建卡片
      new_card = Webhook.new.card(res)
      card_position = Webhook.new.current_list(res)
      byebug
    end
  end
end
