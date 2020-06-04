class ChangeTagToTasksToTagging < ActiveRecord::Migration[6.0]
  def change
    rename_table :tag_to_tasks, :taggings
  end
end
