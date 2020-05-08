class Tictac < ApplicationRecord
  #relationship
  belongs_to :user
  belongs_to :task, require: false

end
