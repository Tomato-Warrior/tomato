class GetCards
  require 'rest-client'

  def get_cards(board_id, api_key, token)
    begin
      RestClient.get "api.trello.com/1/boards/#{board_id}/cards?key=#{api_key}&token=#{token}"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end