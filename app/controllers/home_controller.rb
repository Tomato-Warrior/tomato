class HomeController < ApplicationController
  def index
    @projects = Project.all
    @tictacs = Tictac.all
    @tasks = Task.all
  end
  
end
