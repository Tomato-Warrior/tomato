class Task < ApplicationRecord
  #relationship
  has_many :tag_to_tasks, dependent: :destroy
  has_many :tags, through: :tag_to_tasks
  has_many :tictacs

  belongs_to :project
  belongs_to :user
  #validates
  validates :task_name, presence: true

  # def tag_list=(name)
  #   self.tags = name.split(',').map do |item|
  #     Tag.where(tag_name: item.strip).first_or_create!
  #   end

  # end
  # def tag_list
  #   tags.map(&:tag_name).join(',')
  # end

  def tag_items=(name)
    self.tags = name.map{ |item| 
      Tag.where(tag_name: item.strip).first_or_crate! unless item.blank?}.compact!
  end

  def tag_items
    tags.map(&:tag_name)
  end

  # def self.tagged_with(name)
  #   Tag.find_by!(tag_name: name).tasks
  # end

end
