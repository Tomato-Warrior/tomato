class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
<<<<<<< HEAD

  # ralationship
=======
  # relationship
>>>>>>> fix task/project view
  has_many :counters
  has_many :projects
  has_many :task
  has_many :tasks, through: :projects

  # callback
  after_create :default_project_create

<<<<<<< HEAD
=======
  private
>>>>>>> add default project
  def default_project_create
    project = self.projects.build(project_name: 'Default Box')
    project.save
  end

end
