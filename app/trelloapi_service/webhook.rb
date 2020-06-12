class Webhook
  def create(board_id, api_key, token)
    begin
      RestClient::Request.execute(method: :post, url: "api.trello.com/1/tokens/#{token}/webhooks/?key=#{api_key}",
                                  payload: {
                                  callbackURL: 'http://89bbaac60e9f.ngrok.io/webhooks/receive',
                                  idModel: board_id,
                                  description: "My webhook"},
                                  :content_type => 'application/json') do |response|
                                    byebug
                                    case response.code
                                    when 301, 302, 307
                                      byebug
                                      response.follow_redirection
                                    else
                                      response.return!
                                    end                   
                                   
                                  end                                                     
    rescue RestClient::ExceptionWithResponse => err
    end
  end
end