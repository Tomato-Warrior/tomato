module TrelloHelper
  def list_data_trans(task, token)
    JSON.parse(GetLists.new.get_lists(task.trello_info.board_id,ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], token)).map{|list| list.values_at("name","id")}
  end
end
