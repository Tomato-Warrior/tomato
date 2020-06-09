class AddColumnToProjectForTrello < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :trello_import_method, :string
  end
end
