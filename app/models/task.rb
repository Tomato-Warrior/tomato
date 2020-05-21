class Task < ApplicationRecord
  acts_as_paranoid
  acts_as_list
  
  #relationship
  has_many :tag_to_tasks, dependent: :destroy
  has_many :tags, through: :tag_to_tasks
  has_many :tictacs

  belongs_to :project
  belongs_to :user
  #validates
  validates :task_name, presence: true
  enum status: {doing: 0 , done: 1 }
  ## Task.doing # scope doing task
  ## task = Task.find(1)
  ## task.done! if task.doing?


  # def toggle_status
  #   if self.status == self.doing 
  #     self.done
  #   else
  #     self.doing
  #   end
  # end

  #tag
  def self.tagged_with(name)
    Tag.find_by!(tag_name: name).tasks
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |item|
      Tag.where(tag_name: item.strip).first_or_create!
    end
  end

  def tag_list
    tags.map(&:tag_name).join(',')
  end

  def tag_items=(names)
    cur_tags = names.map do |item| 
      Tag.where(tag_name: item.strip).first_or_create! unless item.blank?
    end.compact
    self.tags = cur_tags
  end

  def tag_items
    tags.map(&:tag_name)
  end

  private

end