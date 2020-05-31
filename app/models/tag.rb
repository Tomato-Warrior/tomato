class Tag < ApplicationRecord
  has_many :taggings
  has_many :tasks, through: :taggings
  has_many :tictacs, through: :tasks

  validates :title, length: { minimum: 1 }
end