class Counter < ApplicationRecord
  #relationship
  belongs_to :user
  belongs_to :task

end
