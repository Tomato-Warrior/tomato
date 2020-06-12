class GetLists
  require 'rest-client'
  require 'uri'
  def get_lists(board_id, api_key, token)
    begin
      RestClient.get "api.trello.com/1/boards/#{board_id}/lists?key=#{api_key}&token=#{token}"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def get_list_cards(list_id, api_key, token)
    begin
      RestClient.get "api.trello.com/1/lists/#{list_id}/cards?key=#{api_key}&token=#{token}"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def get_assigned_cards(member_id, board_name, list_name, api_key, token)
    url = "api.trello.com/1/search?query=member:#{member_id} board:#{board_name} list:#{list_name} sort:edited&list_fields=name,idList&cards_limit=1000&key=#{api_key}&token=#{token}".force_encoding('ASCII-8BIT')
    begin
      RestClient.get URI::encode(url)
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end