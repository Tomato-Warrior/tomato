class GetBoards
  require 'rest-client'
  def initialize()
		
  end
  
  def get_boards(api_key, token)
    begin
      RestClient.get "api.trello.com/1/members/me/boards?key=#{api_key}&token=#{token}"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

  def get_board_name(board_id, api_key, token)
    begin
      RestClient.get "api.trello.com/1/boards/#{board_id}?key=#{api_key}&token=#{token}"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end