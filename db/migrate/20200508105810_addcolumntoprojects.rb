class Addcolumntoprojects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :cover, :string 
  end
end
