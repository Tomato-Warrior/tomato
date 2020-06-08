class AddTimeSettingToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :time_setting, :integer, default: 0, index: true
  end
end
