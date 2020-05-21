class TrelloapiController < ApplicationController
  def index
    config_trelo_public_key()
    @me = Trello::Member.find("user50720802")
    @project = Project.new
    @boards = @me.boards
    #@board = @boards.find { |board| board.name == "TomaTokei"}
    #@all_list = @board.lists.map{|list| list} #["許願池", "To Do", "In Progress", "Done"]
    #@all_card = @board.lists.map{|list| list.cards.map{ |card| card.name}}
    #@tasks_attr_data = @board.lists.map{|list| list.cards.map{|card|  "{task_name: '#{card.name}', trello_status: '#{list.name}', user_id: 1}"}}
    #@tasks_attr_data_trans = @tasks_attr_data.map{|list| list.map{|card| eval(card)}}.flatten 
    
  end

  private
  def config_trelo_public_key
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
      config.member_token = ENV['TRELLO_MEMBER_TOKEN']
    end
  end

  def load_trello_board
    Project.create!(project_name: @board.name,user_id: 1,
                    tasks_attributes:@tasks_attr_data_trans)
  end  
end
