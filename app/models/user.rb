class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  # relationship
  has_many :tictacs
  has_many :projects
  has_many :task
  has_many :tasks, through: :projects

  # callback
  after_create :default_project_create

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end 
  end

  private

  def default_project_create
    project = self.projects.build(project_name: 'Default Box')
    project.save
  end

end
