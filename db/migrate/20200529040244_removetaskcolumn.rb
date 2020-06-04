class Removetaskcolumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :tasks, :trello_status
    remove_column :tasks, :trello_card_id
    remove_column :tasks, :trello_goal_list_id
  end
end
