class ChartsController < ApplicationController
  def index
    # tictac stat.
    @today_tictac = current_user.tictacs.finished.where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).count
    @week_tictac  = current_user.tictacs.finished.where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_week, Time.zone.now.end_of_week).count
    @month_tictac = current_user.tictacs.finished.where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).count
    
    @daily_tictac = current_user.tictacs.group(:status).group_by_day(:end_at).count
    @weekly_tictac = current_user.tictacs.group(:status).group_by_week(:end_at).count
    @monthly_tictac = current_user.tictacs.group(:status).group_by_month(:end_at).count

    # task chart
    @tasks = current_user.tasks
    if @tasks.any?
      @first_task_finished = @tasks.first.tictacs.finished.group_by_day(:end_at).count
    end

    @tasks_arr = []
    @tasks.each do |task|
      task_hash = {}
      task_hash = { id: task.id, title: task.title, tictac: task.tictacs.finished.group_by_day(:end_at).count }
      @tasks_arr << task_hash
    end

    # tag chart
    tags = current_user.tags
    tag_arr = []
    tags.each do |tag|
      tag_arr << tag
    end
    @tags = tag_arr.uniq
    if @tags.count != 0
      @first_tag_finish_tictacs = @tags.first.tictacs.finished.group_by_day(:end_at).count
    end
    
    @tags_arr = []
    @tags.each do |tag|
      tag_hash = {}
      tag_hash = { id: tag.id, name: tag.name, tictac: tag.tictacs.finished.group_by_day(:end_at).count }
      @tags_arr << tag_hash
    end


    # project chart
    @projects = current_user.projects
    @first_project_finished = 0
    @first_project_cancelled = 0
    @projects.first.tasks.each do |task|
      @first_project_finished += task.tictacs.finished.count       
      @first_project_cancelled += task.tictacs.cancelled.count
    end

    @projects_arr = []
    @projects.each do |project|
      @finished = 0
      @cancelled = 0
      project.tasks.each do |task|
        @finished += task.tictacs.finished.count
        @cancelled += task.tictacs.cancelled.count
      end
      project_hash = {}
      project_hash = { id: project.id, title: project.title, finished_tictacs: @finished, cancelled_tictacs: @cancelled }
      @projects_arr << project_hash
    end
  end
end