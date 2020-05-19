class HomeController < ApplicationController
  
  def index
    @projects = current_user.projects
    @tictacs = current_user.tictacs
    @uncoming_task = current_user.tasks.without_deleted
    @finish_task = current_user.tasks.with_deleted
  end
  
end
