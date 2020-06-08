class Webhook
  def create(board_id, api_key, token)
    begin
      RestClient::Request.execute(method: :post, url: "api.trello.com/1/tokens/#{token}/webhooks/?key=#{api_key}",
                                  payload: {D
                                  callbackURL: 'http://c2aff2ed5f96.ngrok.io/webhooks/receive',
                                  idModel: board_id,
                                  description: "My webhook"},
                                  headers:{ :content_type => 'application/json'}) do |response|
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

  def delete(id, api_key, token)
      begin
        RestClient.delete "api.trello.com/1/webhooks/#{id}?key=#{api_key}&token=#{token}" do |response|
                                                                                            case response.code
                                                                                            when 301, 302, 307
                                                                                              response.follow_redirection
                                                                                            else
                                                                                              response.return!
                                                                                            end                   
                                                                                          end                                                    
      rescue RestClient::ExceptionWithResponse => e
        e.response
      end
  end

  def action(res)
    res.values_at("action")[0].values_at("type")[0]
  end

  def board(res)
    res.values_at("action")[0].values_at("data")[0].values_at("board")[0]
  end

  def card(res)
    res.values_at("action")[0].values_at("data")[0].values_at("card")[0]
  end

  def current_list(res)
    res.values_at("action")[0].values_at("data")[0].values_at("list")[0]
  end

  def before_list(res)
    res.values_at("action")[0].values_at("data")[0].values_at("listBefore")[0].values_at("id", "name")
  end

  def after_list(res)
    res.values_at("action")[0].values_at("data")[0].values_at("listAfter")[0].values_at("id", "name")
  end

  def member_id(res)
    res.values_at("action")[0].values_at("memberCreator")[0].values_at("id").join
  end

  def assign_member_id(res)
    res.values_at("action")[0].values_at("data")[0].values_at("idMember")[0]
  end

end