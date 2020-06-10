class TrelloInfo < ApplicationRecord
  belongs_to :task
  has_one :project, through: :task
  belongs_to :user
end
