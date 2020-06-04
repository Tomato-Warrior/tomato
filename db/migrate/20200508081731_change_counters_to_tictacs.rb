class ChangeCountersToTictacs < ActiveRecord::Migration[6.0]
  def change
    rename_table :counters, :tictacs
  end
end
