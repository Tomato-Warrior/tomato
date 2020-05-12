class CreateCounters < ActiveRecord::Migration[6.0]
  def change
    create_table :counters do |t|
      t.string :status
      t.string :reason, default: "Without specific reason!"
      t.datetime :start_at
      t.datetime :end_at
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :task, foreign_key: false

      t.timestamps
    end
  end
end