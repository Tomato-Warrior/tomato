class CreateCounters < ActiveRecord::Migration[6.0]
  def change
    create_table :counters do |t|
      t.string :status
      t.string :reason, default: "Without specific reason!"
      t.datetime :start_at
      t.datetime :end_at
      t.integer :user_id

      t.timestamps
    end
  end
end
