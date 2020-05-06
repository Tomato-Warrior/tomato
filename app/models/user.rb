class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # ralationship
  has_many :counter

  #callback
  # after_create :default_project_create
  


  # def default_project_create
  #   @project = Project.new(project_name: 'Default Box')
  #   @project.user = current_user
  # end

end
