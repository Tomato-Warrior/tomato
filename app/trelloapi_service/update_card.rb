class UpdateCard
  require 'rest-client'
  def move_to_list(card_id, list_id, api_key, token)
    begin
      RestClient::Request.execute(method: :put, url: "api.trello.com/1/cards/#{card_id}?idList=#{list_id}&key=#{api_key}&token=#{token}",:content_type => 'application/json',
                                  max_redirects: 0)
    rescue RestClient::ExceptionWithResponse => err
    end
  end

end