class UpdateCard
  require 'rest-client'
  def move_to_list
    begin
      RestClient.get "api.trello.com/1/cards/#{card_id}?idList=#{list_id}&key=#{api_key}&token=#{token}"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end

end