class Addcolumntoprojects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :project_cover, :string 
  end
end
