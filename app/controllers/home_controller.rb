class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @projects = current_user.projects
    @tictacs = current_user.tictacs
    range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    @undone_today_tasks = current_user.tasks.where(created_at: range).doing
    @done_today_tasks = current_user.tasks.where(created_at: range).done
    @task = Task.new
  end
  
end
