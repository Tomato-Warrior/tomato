class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # relationship
  has_many :tictacs
  has_many :projects
  has_many :task
  has_many :tasks, through: :projects

  # callback
  after_create :default_project_create

  private

  def default_project_create
    project = self.projects.build(project_name: 'Default Box')
    project.save
  end

end
