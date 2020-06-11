class GetMember
  def get_member_id(api_key, token)
    begin
      RestClient.get "api.trello.com/1/members/me?key=#{api_key}&token=#{token}"
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end