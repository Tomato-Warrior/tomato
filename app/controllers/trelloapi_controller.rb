class TrelloapiController < ApplicationController
  
  layout "trelloapi"
  #全域變數  
  $token
  $board_id
  $member_id
  def get_token
    $token = params[:token]
    $member_id = JSON.parse(params[:text]).values_at("id").join
  end

  def get_board
    $board_id = params[:board_id]
    render json: { cards_data: params[:cards_data] }, status: 200
  end

  def index
  end

  def select_board
    @project = Project.new
    boards_data = GetBoards.new.get_boards(ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    boards = JSON.parse(boards_data)
    boards_id = boards.map{|board| board.values_at("id")}.flatten
    boards_name = boards.map{|board| board.values_at("name")}.flatten
    @boards_name_id = boards_name.zip(boards_id)
  end

  def select_list_cards
    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    @lists = JSON.parse(lists_data)
    @lists_name = @lists.map{|list| list.values_at("name")}.flatten
    @lists_id = @lists.map{|list| list.values_at("id")}.flatten
  end

  def select_assigned_cards_of_list
    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    @lists = JSON.parse(lists_data)
    @lists_name = @lists.map{|list| list.values_at("name")}.flatten
    @lists_id = @lists.map{|list| list.values_at("id")}.flatten
  end

  def import_selected_list
    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    lists = JSON.parse(lists_data)
    lists_name = lists.map{|list| list.values_at("name")}.flatten
    lists_id = lists.map{|list| list.values_at("id")}.flatten
    @param_list_names = [] #拿到list name
    lists_name.each{|list| 
                    if params[:"#{list}"] != nil
                      @param_list_names.append(params[:"#{list}"])
                    end
                  }
    name_id_chart = Hash[lists_name.zip(lists_id)]
    @param_list_id = @param_list_names.map{|name| name_id_chart.values_at(name)}.flatten #拿到list name的id
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

    redirect_to root_path, notice: '專案成功匯入喵'
  end

  def import_assigned_cards
    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    lists = JSON.parse(lists_data)
    lists_name = lists.map{|list| list.values_at("name")}.flatten
    lists_id = lists.map{|list| list.values_at("id")}.flatten
    @param_list_names = [] #拿到list name
    lists_name.each{|list| 
    if params[:"#{list}"] != nil
      @param_list_names.append(params[:"#{list}"])
    end
    }
    data = @param_list_names.map{|list_name| get_assigned_cards_data( $member_id, $board_id, list_name,  ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)}
   
    byebug
  end


  private

  def generate_tasks_attributes
    i=0
    @tasks_attr_data=[]

    while i<@param_list_id.count
      params = @param_card_name[i].map{ |card| "{title: '#{card}', trello_status: '#{@param_list_names[i]}', user_id: '#{current_user.id}'}"}
      @tasks_attr_data.append(params)
      i += 1
    end
    
    @tasks_attr_data = @tasks_attr_data.map{|list| list.map{|card| eval(card)}}.flatten 
    return @tasks_attr_data
  end

  def load_trello_board
    current_user.projects.create!(project_name: @param_board_name,
                                  tasks_attributes:@tasks_attr_data)

  end  

  def get_assigned_cards_data(member_id, board_id, list_name, api_key, token)
    @assigned_cards = JSON.parse(GetLists.new.get_assigned_cards(member_id, board_id, list_name, api_key, token)).values_at("cards").flatten
  end
end
