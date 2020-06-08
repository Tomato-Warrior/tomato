class GetCards
  require 'rest-client'
  require 'uri'
  def get_cards(board_id, api_key, token)
    begin
      RestClient.get "api.trello.com/1/boards/#{board_id}/cards?key=#{api_key}&token=#{token}"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def get_card_by_id(card_id, api_key, token)
    begin
      RestClient.get "api.trello.com/1/cards/#{card_id}/list?key=#{api_key}&token=#{token}"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
  def get_list_card(board_name, list_name, api_key, token)
    url = "api.trello.com/1/search?query=board:#{board_name} list:#{list_name} sort:edited&card_fields=name,idList&cards_limit=1000&key=#{api_key}&token=#{token}"
    url = URI::encode(url)
    begin
      RestClient.get url
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end