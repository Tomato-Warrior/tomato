class Addcolumntouser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :trello_token, :string
  end
end
