class AddColumnToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :webhook_id, :string
  end
end
