class AddTrelloCardId < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :trello_card_id, :string
    add_column :tasks, :trello_goal_list_id, :string
  end
end
