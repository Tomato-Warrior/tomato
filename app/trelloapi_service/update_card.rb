class UpdateCard
  require 'rest-client'
  def move_to_list(card_id, list_id, api_key, token)
    begin
      RestClient::Request.execute(method: :put, url: "api.trello.com/1/cards/#{card_id}?idList=#{list_id}&key=#{api_key}&token=#{token}",
                                  payload: {id: card_id, idList: list_id,},
                                  :content_type => 'application/json') do |response|
        case response.code
        when 301, 302, 307
          response.follow_redirection
        else
          response.return!
        end                           
      end
                                  
    rescue RestClient::ExceptionWithResponse => err
    end
  end

end