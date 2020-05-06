class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ralationship
  has_many :counters
  has_many :projects
  # callback
  after_commit :default_project_create
  

<<<<<<< HEAD
=======
  private
>>>>>>> add default project
  def default_project_create
    project = self.projects.build(project_name: 'Default Box')
    project.save
  end

end
