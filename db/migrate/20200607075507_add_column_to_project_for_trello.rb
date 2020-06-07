<<<<<<< HEAD
class AddColumnToProjectForTrello < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :trello_import_method, :string
  end
end
=======
class AddColumnToProjectForTrello < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :trello_import_method, :string
  end
end
>>>>>>> 選擇匯入指定任務不後不會更新出不是自己的卡片
