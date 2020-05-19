class TrelloapiController < ApplicationController
  def index
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
      config.member_token = ENV['TRELLO_MEMBER_TOKEN']
    end
    @me = Trello::Member.find("user50720802")
  end
end
