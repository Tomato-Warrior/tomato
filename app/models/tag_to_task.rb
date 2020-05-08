class TagToTask < ApplicationRecord
  belongs_to :tag
  belongs_to :task
  self.table_name = "tagging"
end
