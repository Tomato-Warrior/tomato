class CreateTrelloInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :trello_infos do |t|
      t.string :list_id
      t.string :card_id
      t.belongs_to :task, null: false, foreign_key: true
      t.timestamps
    end
  end
end
