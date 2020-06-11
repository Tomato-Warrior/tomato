class TrelloapiController < ApplicationController

  before_action :ajax_render, only: [:select_board, :select_list_cards, :select_assigned_cards_of_list]
  layout "trelloapi"
  #全域變數  
  $board_id
  $member_id
  def get_token
    data = JSON.parse(params[:data])
    trello_member_id = data.values_at("id").join
    if trello_acount_already_exist?(trello_member_id)
      redirect_to root_path, alert:"帳號已被其他使用者登入"
    else
      current_user.update(trello_token: params[:token], trello_member_id: trello_member_id)
      redirect_to root_path
    end
  end

  def get_board
    $board_id = params[:board_id]
    render json: { cards_data: params[:cards_data] }, status: 200
  end

  def change_list
    card_id = params[:card_id]
    list_id = params[:list_id]
    task_id = params[:task_id]
    response = UpdateCard.new.move_to_list(card_id, list_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    render json: {res: response}
    data = JSON.parse(response)
    list_id = data.values_at("idList")
    list_info = GetLists.get_list_info(list_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    list_name = JSON.parse(list_info).values_at("name")
    Task.find(task_id).trello_info.update(list_id: list_id, list_name: list_name)
  end

  def get_list_data 
    task = Task.find(params[:task_id])
    data = list_data_trans(task, current_user.trello_token)
    render json: {list_data: data}
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
    id_name_chart = Hash[lists_id.zip(lists_name)]
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
    import_data = import_trello_board(@param_board_name, "import_all_card", @tasks_attr_data)
    all_cards = GetCards.new.get_cards($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    all_cards = JSON.parse(all_cards)
    list_data = param_card_ids.flatten.map{|card| GetCards.new.get_card_by_id(card, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)}
    list_ids = list_data.map{|list| JSON.parse(list).values_at("id")}.flatten
    list_names = list_data.map{|list| JSON.parse(list).values_at("name")}.flatten
    create_trello_info(import_data, param_card_ids, list_ids, list_names, $board_id, current_user.id)
    response = Webhook.new.create($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    webhook_id = JSON.parse(response).values_at("id")[0]
    import_data.update(webhook_id:webhook_id)
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
    assigned_cards_data = @param_list_names.map{|list_name| get_assigned_cards_data( current_user.trello_member_id, $board_id, list_name,  ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)}
    assigned_cards_names = assigned_cards_data.map{|list| list.map{|card| card.values_at("name")}.flatten}
    assigned_cards_ids = assigned_cards_data.map{|list| list.map{|card| card.values_at("id")}}.flatten
    assigned_cards_list_ids = assigned_cards_data.map{|list| list.map{|card| card.values_at("idList")}}.flatten
    assigned_cards_list_names = assigned_cards_ids.map{|id| JSON.parse(GetLists.new.get_list_name(id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)).values_at("name")}.flatten
    board_name = JSON.parse(GetBoards.new.get_board_name($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token))
    board_name = board_name.values_at("name").join
    generate_tasks_attributes(assigned_cards_names, @param_list_names.count) 
    import_data = import_trello_board(board_name, "import_assign_card", @tasks_attr_data) 
    create_trello_info(import_data, assigned_cards_ids, assigned_cards_list_ids, assigned_cards_list_names, $board_id, current_user.id)      
    response = Webhook.new.create($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token)
    webhook_id = JSON.parse(response).values_at("id")[0]
    import_data.update(webhook_id:webhook_id)             
    redirect_to root_path
  end

  private

  def generate_tasks_attributes(card_names, lists_num)
    i=0
    @tasks_attr_data = []
    while i < lists_num
      params = card_names[i].map{ |card| "{title: '#{card}', 
                                          user_id: '#{current_user.id}'}"}
      @tasks_attr_data.append(params)
      i += 1
    end
    @tasks_attr_data = @tasks_attr_data.map{|list| list.map{|card| eval(card)}}.flatten 
    return @tasks_attr_data
  end

  def import_trello_board(board_name, import_way, tasks_attr_data)
    current_user.projects.create(title: board_name, trello_import_method: import_way,
                                  tasks_attributes: tasks_attr_data)
  end  

  def get_assigned_cards_data(member_id, board_id, list_name, api_key, token)
    @assigned_cards = JSON.parse(GetLists.new.get_assigned_cards(member_id, board_id, list_name, api_key, token)).values_at("cards").flatten
  end

  def create_trello_info(import_data, card_ids, list_ids, list_names, board_id, user_id)
    i=0
    while i<import_data.tasks.count
      import_data.tasks[i].create_trello_info({card_id:card_ids.flatten[i], list_id:list_ids[i], list_name:list_names[i], board_id:board_id, user_id: user_id })
      i += 1
    end  
  end

  def ajax_render
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def list_data_trans(task, token)
    JSON.parse(GetLists.new.get_lists(task.trello_info.board_id,ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], token)).map{|list| list.values_at("name","id")}
  end
  
  def trello_acount_already_exist?(trello_member_id)
    if User.find_by(trello_member_id:trello_member_id) == nil
      false
    else
      true
    end
  end
end