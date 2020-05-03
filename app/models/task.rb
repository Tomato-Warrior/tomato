class Task < ApplicationRecord
    has_many :tag_to_tasks
    has_many :tags, through: :tag_to_tasks

    belongs_to :project
end
