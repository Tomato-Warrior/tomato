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

  def get_list_card(board_name, list_name, api_key, token)
    url = "api.trello.com/1/search?query=board:#{board_name}%20list:#{list_name}%20sort:edited&card_fields=name,idList&cards_limit=1000&key=#{api_key}&token=#{token}".force_encoding('ASCII-8BIT')
    begin
      RestClient.get URI::encode(url)
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end