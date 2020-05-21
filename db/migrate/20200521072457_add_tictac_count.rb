class AddTictacCount < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :tictac_finish_count, :integer, default: 0

    Task.includes(:user).each do |task|
      task.tictacs.where(status: 'finished')
    end

  end
end
