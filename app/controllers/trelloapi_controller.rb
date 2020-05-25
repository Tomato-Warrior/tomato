class TrelloapiController < ApplicationController
  
  layout "trelloapi"
  #全域變數  
  $token
  $board_id
  $member_id
  def get_token
    $token = params[:token]
    ENV['TRELLO_USER_TOKEN'] = params[:token]
    current_user.update(trello_token: params[:token])
    $member_id = JSON.parse(params[:text]).values_at("id").join
  end

  def get_board
    $board_id = params[:board_id]
    render json: { cards_data: params[:cards_data] }, status: 200
  end

  def change_list
    card_id = params[:card_id]
    list_id = params[:list_id]
    task_id = params[:task_id]
    response = UpdateCard.new.move_to_list(card_id, list_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], ENV['TRELLO_USER_TOKEN'])
    
    render json: {res: response}
    Task.find(task_id).trello_info.update(list_id: list_id)
  end

  def index
  end

  def select_board
    @project = Project.new
    boards_data = GetBoards.new.get_boards(ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    boards = JSON.parse(boards_data)
    boards_id = boards.map{|board| board.values_at("id")}.flatten
    boards_name = boards.map{|board| board.values_at("name")}.flatten
    @boards_name_id = boards_name.zip(boards_id)
  end

  def select_list_cards
    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    @lists = JSON.parse(lists_data)
    lists_name = @lists.map{|list| list.values_at("name")}.flatten
    lists_id = @lists.map{|list| list.values_at("id")}.flatten
    @name_id_chart = Hash[lists_name.zip(lists_id)]
  end

  def select_assigned_cards_of_list
    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    @lists = JSON.parse(lists_data)

    @cards = JSON.parse($cards_data)
    @cards_name = @cards.map{|card| card.values_at("name")}.flatten
    @cards_list_id = @cards.map{|card| card.values_at("idList")}.flatten
    @lists = JSON.parse($lists_data)
    @lists_name = @lists.map{|list| list.values_at("name")}.flatten
    @lists_id = @lists.map{|list| list.values_at("id")}.flatten
  end

  def import_selected_list
    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    lists = JSON.parse(lists_data)
    lists_name = lists.map{|list| list.values_at("name")}.flatten
    lists_id = lists.map{|list| list.values_at("id")}.flatten
    @param_list_names = [] #拿到list name
    lists_name.each{|list| 
                    if params[:"#{list}"] != nil
                      @param_list_names.append(params[:"#{list}"])
                    end
                  }
    @name_id_chart = Hash[lists_name.zip(lists_id)]
    @param_list_id = @param_list_names.map{|name| @name_id_chart.values_at(name)}.flatten #拿到list name的id
    param_card_names = []
    param_card_ids = []
    @param_list_id.each{|id| 
                        param_card_names.append(JSON.parse(GetLists.new.get_list_cards(id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)).flatten)
                        param_card_ids.append(JSON.parse(GetLists.new.get_list_cards(id,ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)).flatten)
                      }
    param_card_names = param_card_names.map{|cards| cards.map{|card| card.values_at("name")}.flatten} #拿到cards name
    param_card_ids = param_card_ids.map{|cards| cards.map{|card| card.values_at("id")}.flatten} #拿到cards id

    #製作巢狀參數                  
    generate_tasks_attributes(param_card_names, @param_list_id.count)

    boards_data = GetBoards.new.get_boards(ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    boards = JSON.parse(boards_data)
    boards_id = boards.map{|board| board.values_at("id")}.flatten
    boards_name = boards.map{|board| board.values_at("name")}.flatten
    name_index = boards_id.index($board_id)
    @param_board_name = boards_name[name_index] #拿到board name
    #create project and tasks
    
    import_data = import_trello_board(@param_board_name, @tasks_attr_data)
    all_cards = GetCards.new.get_cards($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    all_cards = JSON.parse(all_cards)
    list_ids = param_card_ids.flatten.map{|card| GetCards.new.get_card_by_id(card, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)}
    list_ids = list_ids.map{|list| JSON.parse(list).values_at("idList")}.flatten
    create_trello_info(import_data, param_card_ids, list_ids, $board_id)

    redirect_to root_path
  end

  def import_assigned_cards
    lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    lists = JSON.parse(lists_data)
    lists_name = lists.map{|list| list.values_at("name")}.flatten
    lists_id = lists.map{|list| list.values_at("id")}.flatten
    @param_list_names = [] #拿到list name
    lists_name.each{|list| 
                      if params[:"#{list}"] != nil
                        @param_list_names.append(params[:"#{list}"])
                      end
                    }
    assigned_cards_data = @param_list_names.map{|list_name| get_assigned_cards_data( $member_id, $board_id, list_name,  ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)}
    assigned_cards_names = assigned_cards_data.map{|list| list.map{|card| card.values_at("name")}.flatten}
    assigned_cards_ids = assigned_cards_data.map{|list| list.map{|card| card.values_at("id")}}.flatten
    assigned_cards_list_ids = assigned_cards_data.map{|list| list.map{|card| card.values_at("idList")}}.flatten

    board_name = JSON.parse(GetBoards.new.get_board_name($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token))
    board_name = board_name.values_at("name").join
    
    generate_tasks_attributes(assigned_cards_names, @param_list_names.count) 
    import_data = import_trello_board(board_name, @tasks_attr_data) 
    create_trello_info(import_data, assigned_cards_ids, assigned_cards_list_ids,$board_id)
                      
    redirect_to root_path
  end


  private

  def generate_tasks_attributes(card_names, lists_num)
    i=0
    @tasks_attr_data=[]
    while i<lists_num
      params = card_names[i].map{ |card| "{title: '#{card}', 
                                          user_id: '#{current_user.id}'}"}
      @tasks_attr_data.append(params)
      i += 1
    end
    @tasks_attr_data = @tasks_attr_data.map{|list| list.map{|card| eval(card)}}.flatten 
    return @tasks_attr_data
  end

  def import_trello_board(board_name, tasks_attr_data)
    current_user.projects.create!(title: board_name,
                    tasks_attributes: tasks_attr_data)
  end  

  def get_assigned_cards_data(member_id, board_id, list_name, api_key, token)
    @assigned_cards = JSON.parse(GetLists.new.get_assigned_cards(member_id, board_id, list_name, api_key, token)).values_at("cards").flatten
  end

  def create_trello_info(import_data, card_ids, list_ids, board_id)
    i=0
    while i<import_data.tasks.count
      import_data.tasks[i].create_trello_info({card_id:card_ids.flatten[i], list_id:list_ids[i], board_id:board_id })
      i += 1
    end  
  end
end