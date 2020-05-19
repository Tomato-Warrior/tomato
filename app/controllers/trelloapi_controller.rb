class TrelloapiController < ApplicationController
  def index
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
      config.member_token = ENV['TRELLO_MEMBER_TOKEN']
    end
    @me = Trello::Member.find("user50720802")

    boards = @me.boards
    @board = boards.find { |board| board.name == "TomaTokei"}
    @list = Trello::Board.find('5eb2227c12578348eb4168f8').lists
    
  end
end
