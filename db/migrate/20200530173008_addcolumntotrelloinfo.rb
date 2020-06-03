class Addcolumntotrelloinfo < ActiveRecord::Migration[6.0]
  def change
    add_column :trello_infos, :board_id, :string
  end
end
