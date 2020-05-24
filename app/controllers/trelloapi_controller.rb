class TrelloapiController < ApplicationController
  require 'trello'
  layout "trelloapi"
  #全域變數
  $boards_data 
  $lists_data 
  $cards_data  
  def get_boards
    $boards_data = params[:boards_data]
  end

  def get_cards
    $cards_data = params[:cards_data]
    render json: { cards_data: params[:cards_data] }, status: 200
  end

  def get_lists
    $lists_data = params[:lists_data]
    render json: { lists_data: params[:lists_data] }, status: 200
  end

  def index
  end

  def import_selection
    @project = Project.new
    boards = JSON.parse($boards_data)
    boards_id = boards.map{|board| board.values_at("id")}.flatten
    boards_name = boards.map{|board| board.values_at("name")}.flatten
    @boards_name_id = boards_name.zip(boards_id)
    #@me = Trello::Member.find(@username)
    #@boards = @me.boards
    #@boards_name = @boards.map{|board| board.name}
    #@board = @boards.find { |board| board.name == "TomaTokei"}
    #@all_list = @board.lists.map{|list| list} #["許願池", "To Do", "In Progress", "Done"]
    #@all_card = @board.lists.map{|list| list.cards.map{ |card| card.name}}
    #@tasks_attr_data = @board.lists.map{|list| list.cards.map{|card|  "{task_name: '#{card.name}', trello_status: '#{list.name}', user_id: 1}"}}
    #@tasks_attr_data_trans = @tasks_attr_data.map{|list| list.map{|card| eval(card)}}.flatten 
  end

  def select_list_cards
    @cards = JSON.parse($cards_data)
    @lists = @cards.map{|card| card.values_at("idList")}.flatten

    @lists = JSON.parse($lists_data)
    @lists_name = @lists.map{|list| list.values_at("name")}.flatten
    @lists_id = @lists.map{|list| list.values_at("id")}.flatten
  end






  private
  def config_trelo_public_key
    Trello.configure do |config|
      config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
      config.member_token = $token
    end
  end

  def load_trello_board
    Project.create!(project_name: @board.name,
                    tasks_attributes:@tasks_attr_data_trans)
  end  
end
