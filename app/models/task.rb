class Task < ApplicationRecord
    #relationship
    has_many :tag_to_tasks
    has_many :tags, through: :tag_to_tasks
    has_many :counters

    belongs_to :project
    belongs_to :user
    #validates
    validates :task_name, presence: true


end
