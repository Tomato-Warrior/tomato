class Project < ApplicationRecord

  # relationship
  belongs_to :user
  has_many :tasks

end
