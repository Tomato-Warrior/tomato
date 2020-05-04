class Tag < ApplicationRecord
    has_many :tag_to_tasks
    has_many :tasks, through: :tag_to_tasks
end
