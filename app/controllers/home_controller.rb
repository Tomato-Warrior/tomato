class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @projects = current_user.projects
    @tictacs = current_user.tictacs
    @undone_today_tasks = current_user.tasks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).where(status: true)
    @done_today_tasks = current_user.tasks.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).where(status: false)
    @task = Task.new
  end
  
end
