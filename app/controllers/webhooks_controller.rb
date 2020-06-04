class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  $response
  def complete
    @res = $response
    action = @res.values_at("action")[0].values_at("type")[0]
    board = @res.values_at("action")[0].values_at("data")[0].values_at("board")
    if action == "updateCard"
    #移動卡片
    card_id = @res.values_at("action")[0].values_at("data")[0].values_at("card")[0].values_at("id").join
    @before_list = @res.values_at("action")[0].values_at("data")[0].values_at("listBefore")[0].values_at("id", "name")
    @after_list = @res.values_at("action")[0].values_at("data")[0].values_at("listAfter")[0].values_at("id", "name")
    
    @target_task = TrelloInfo.where(card_id: card_id)
    elsif action == "createCard"
    #新建卡片
    new_card = @res.values_at("action")[0].values_at("data")[0].values_at("card")
    card_position = @res.values_at("action")[0].values_at("data")[0].values_at("list")
    end
    render status: 200
  end

  def receive
    $response = JSON.parse(request.body.read)
  end
end
