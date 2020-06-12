class AddColumnToTrelloInfo < ActiveRecord::Migration[6.0]
  def change
    add_reference :trello_infos, :user
  end
end
