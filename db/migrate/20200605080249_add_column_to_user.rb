class AddColumnToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :trello_member_id, :string
  end
end
