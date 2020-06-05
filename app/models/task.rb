class Task < ApplicationRecord
  acts_as_paranoid
  acts_as_list scope: [ :project_id ]
  
  #relationship
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :tictacs
  has_one :trello_info
  belongs_to :project
  belongs_to :user
  #validates
  validates :title, presence: true
  enum status: { doing: 0 , done: 1 }

  #tag
  def self.tagged_with(name)
    Tag.find_by!(name: name).tasks
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |name|
      Tag.find_or_create_by(name: name.strip)
    end
  end

  def tag_list
    tags.map(&:name).join(',')
  end

  def tag_items=(names)
    current_tags = names.map do |name| 
      Tag.find_or_create_by(name: name.strip) if name.present?
    end.compact
    self.tags = current_tags
  end

  def tag_items
    tags.map(&:name)
  end

end