class AddColumnToTrelloInfo < ActiveRecord::Migration[6.0]
  def change
    add_reference :trello_infos, :user, null: false, foreign_key: true
  end
end
