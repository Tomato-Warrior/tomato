class TrelloInfo < ApplicationRecord
  belongs_to :task
  has_one :project, through: :task
end
