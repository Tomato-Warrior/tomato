class HomeController < ApplicationController
  
  def index
    # @projects = Project.all
    # @tictacs = Tictac.all
    # @uncoming_task = Task.without_deleted
    # @finish_task = Task.with_deleted

    @projects = current_user.projects
    @tictacs = current_user.tictacs
    @uncoming_task = current_user.tasks.without_deleted
    @finish_task = Task.with_deleted
  end
  
end
