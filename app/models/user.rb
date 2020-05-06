class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ralationship
  has_many :counters
  has_many :projects
  # callback
  after_create :default_project_create
  

  def default_project_create
    @project = Project.new(project_name: 'Default Box')
    @project.save
  end

end
