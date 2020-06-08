class AddColumnToTrelloInfoForName < ActiveRecord::Migration[6.0]
  def change
    add_column :trello_infos, :list_name, :string
  end
end
