class AddTrelloStatusToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :trello_status, :string
  end
end
