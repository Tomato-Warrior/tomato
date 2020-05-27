class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    @tictacs = current_user.tictacs.where(end_at: range).finished
    @undo_today_tasks = current_user.tasks.where(created_at: range).doing
    @done_today_tasks = current_user.tasks.where(created_at: range).done
    @task = Task.new
    @expect_time = expect_time
  end

  def expect_time
    range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    tictacs_hour = current_user.tasks.where(created_at: range).sum(:expect_tictacs) * 1500.0  / 3600
    tictacs_hour.round(tictacs_hour % 10 == 0 ? 0 : 1)
  end
  
  def todo
    range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    @tictacs = current_user.tictacs.where.not(end_at: range).finished
    @undo_tasks = current_user.tasks.where.not(created_at: range).doing
    @done_tasks = current_user.tasks.where.not(created_at: range).done
  end

end
