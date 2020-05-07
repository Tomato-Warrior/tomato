class Project < ApplicationRecord
  #relationship
  belongs_to :user
  has_many :tasks

  #validates
  validates :project_name, presence: true,
                           length: { minimum: 4, maximum: 20 }

end
