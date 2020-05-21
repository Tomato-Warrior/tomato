class ApplicationController < ActionController::Base
  before_action :nav_find_projects

  def nav_find_projects
    @projects = current_user.projects.order(updated_at: :desc) if current_user
  end

end
