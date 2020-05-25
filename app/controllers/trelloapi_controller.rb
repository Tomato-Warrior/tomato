class TrelloapiController < ApplicationController
<<<<<<< HEAD
  
  layout "trelloapi"
  #全域變數  
  $token
  $board_id
  def get_boards
    $token = params[:token]
  end

  def get_cards
    $board_id = params[:board_id]
    render json: { cards_data: params[:cards_data] }, status: 200
  end

  def get_selection
    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    lists = JSON.parse(lists_data)
    lists_name = lists.map{|list| list.values_at("name")}.flatten
    lists_id = lists.map{|list| list.values_at("id")}.flatten
    @param_list_name = [] #拿到list name
    lists_name.each{|list| 
                    if params[:"#{list}"] != nil
                      @param_list_name.append(params[:"#{list}"])
                    end
                  }
    name_id_chart = Hash[lists_name.zip(lists_id)]
    @param_list_id = @param_list_name.map{|name| name_id_chart.values_at(name)}.flatten #拿到list name的id
    @param_card_name = []
    @param_list_id.each{|id| 
                        @param_card_name.append(JSON.parse(GetLists.new.get_list_cards(id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token )).flatten)
                      }
    @param_card_name = @param_card_name.map{|cards| cards.map{|card| card.values_at("name")}.flatten} #拿到cards name
    
    #製作巢狀參數                  
    generate_tasks_attributes()

    boards_data = GetBoards.new.get_boards(ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    boards = JSON.parse(boards_data)
    boards_id = boards.map{|board| board.values_at("id")}.flatten
    boards_name = boards.map{|board| board.values_at("name")}.flatten
    name_index = boards_id.index($board_id)
    @param_board_name = boards_name[name_index] #拿到board name
    #create project and tasks
    load_trello_board()
=======
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
>>>>>>> add select cards page WIP
  end

  def index
  end

  def import_selection
    @project = Project.new
<<<<<<< HEAD
    boards_data = GetBoards.new.get_boards(ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    boards = JSON.parse(boards_data)
=======
    boards = JSON.parse($boards_data)
>>>>>>> add select cards page WIP
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
<<<<<<< HEAD
    cards_data = GetCards.new.get_cards($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    @cards = JSON.parse(cards_data)
    @cards_name = @cards.map{|card| card.values_at("name")}.flatten
    @cards_list_id = @cards.map{|card| card.values_at("idList")}.flatten

    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    @lists = JSON.parse(lists_data)
=======
    @cards = JSON.parse($cards_data)
    @cards_name = @cards.map{|card| card.values_at("name")}.flatten
    @cards_list_id = @cards.map{|card| card.values_at("idList")}.flatten
    @lists = JSON.parse($lists_data)
>>>>>>> add checkbox for card
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
