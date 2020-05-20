class HomeController < ApplicationController
  
  def index
    @projects = current_user.projects
    @tictacs = current_user.tictacs
    @today_tasks = current_user.tasks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @finish_task = current_user.tasks.with_deleted
  end
  
end
