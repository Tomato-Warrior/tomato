class Tictac < ApplicationRecord
  #relationship
  belongs_to :user
  belongs_to :task, required: false

end
