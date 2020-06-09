class AddBoardId < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :trello_board_id, :string
  end
end
