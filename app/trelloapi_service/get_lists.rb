class GetLists
  require 'rest-client'
  def initialize()
		
  end

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
end