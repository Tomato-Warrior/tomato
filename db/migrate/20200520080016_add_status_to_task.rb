class AddStatusToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :status, :integer, :default => 0
  end
end
