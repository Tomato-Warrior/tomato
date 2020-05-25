class Project < ApplicationRecord
  acts_as_paranoid
  
  #relationship
  belongs_to :user
  has_many :tasks, dependent: :destroy

  #validates
  validates :title, presence: true,
                           length: { minimum: 1, maximum: 20 }

end
