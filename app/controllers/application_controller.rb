class ApplicationController < ActionController::Base
  before_action :nav_find_projects, :today_expect_time_of_tasks, :undo_tasks, :todo_expect_time_of_tasks, :left_todo_undo_tasks, :find_user
  
  def nav_find_projects
    @projects = current_user.projects.includes(:user).order(updated_at: :desc) if user_signed_in?
  end

  def add_project
    @project = Project.new
  end

  def today_expect_time_of_tasks
    if user_signed_in?
      @expect_time = expect_time
    else
      @expect_time = 0
    end
  end

  def undo_tasks
    if user_signed_in?
      range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
      @undo_tasks = current_user.tasks.where(created_at: range).doing.count
    else
      @undo_tasks = 0
    end
  end

  def todo_expect_time_of_tasks
    if user_signed_in?
      @todo_expect_time = todo_expect_time
    else
      @todo_expect_time = 0
    end
  end

  def left_todo_undo_tasks
    if user_signed_in?
      range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
      @left_todo_undo_tasks = current_user.tasks.where.not(created_at: range).doing.count
    else
      @left_todo_undo_tasks = 0
    end
  end

  def find_user
    @user = current_user
  end
  
  def verified_request?
    if request.content_type == "application/json"
      true
    else
      super()
    end 
  end 
  private
  def expect_time
    range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    tictac_hours = current_user.tasks.where(created_at: range).sum(:expect_tictacs) * 1500.0 / 3600 
    tictac_hours.round(tictac_hours % 10 == 0 ? 0 : 1)
  end

  def todo_expect_time
    range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    tictac_hours = current_user.tasks.where.not(created_at: range).sum(:expect_tictacs) * 1500.0 / 3600 
    tictac_hours.round(tictac_hours % 10 == 0 ? 0 : 1)
  end

end