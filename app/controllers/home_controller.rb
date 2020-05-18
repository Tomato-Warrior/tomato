class HomeController < ApplicationController
  layout "home"
  
  def index
    @projects = Project.all
    @tictacs = Tictac.all
    tasks = Task.all
    @uncoming_task = Task.without_deleted
    @finish_task = Task.with_deleted
    
  end
  
end
