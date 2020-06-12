class ProjectsController < ApplicationController
  before_action :find_project, only: [:edit, :update, :destroy, :show, :chart]
  
  def index
    current_user.projects.includes(:user) if user_signed_in?
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def show
    @task = Task.new
    @project_undo_tasks = @project.tasks.doing
    @project_done_tasks = @project.tasks.done
    task_ids = @project.tasks.ids
    @tictac_count = Tictac.where(task_id: task_ids).finished.count
    @project_expect_time = project_expect_time
  end

  def destroy
    if current_user.projects.count == 1
      redirect_to root_path, alert: '最少要有一個專案！'
    else
      @project.destroy
      Webhook.new.delete(@project.webhook_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], current_user.trello_token) if @project.webhook_id
      redirect_to root_path
    end
  end

  def chart
    # pie chart
    @trello_project_finished = 0
    @trello_project_cancelled = 0
    trello_board_projects = []

    if @project.trello_board_id != nil
      trello_board_projects = Project.where(trello_board_id: @project.trello_board_id)
      trello_board_projects.each do |project|
        project.tasks.each do |task|
          @trello_project_finished += task.tictacs.finished.count       
          @trello_project_cancelled += task.tictacs.cancelled.count
        end
      end
    end

    # data table
    @task_finished_finished = 0
    @task_cancelled_cancelled = 0
    trello_infos = []
    trello_tasks_id = []

    if @project.trello_board_id != nil
      trello_infos = TrelloInfo.where(board_id: @project.trello_board_id)

      trello_infos.each do |trello_info|
        trello_tasks_id << trello_info.task_id
        trello_tasks_id.uniq!
      end

      @tasks_arr = []
      trello_tasks_id.each do |trello_task_id|
        @task_arr = []
        trello_infos.each do |trello_info|
          @title_arr = []
          @finish_arr = []
          @cancel_arr = []
          @list_name_arr = []

          if trello_info.task_id == trello_task_id
            @title_arr << trello_info.task.title
            @finish_arr << trello_info.task.tictacs.finished.count
            @cancel_arr << trello_info.task.tictacs.cancelled.count
            @list_name_arr << trello_info.list_name
          end
          @title = @title_arr.uniq.join
          @finished_total = @finish_arr.sum
          @cancel_total = @cancel_arr.sum
          @list_name = @list_name_arr.uniq.join
          
          if trello_info.task_id == trello_task_id
            @task_arr.push(@title, @finished_total, @cancel_total, @list_name)
          end
        end
        @tasks_arr << @task_arr
      end
    end

  end

  private

  def project_params
    params.require(:project).permit(:title, :cover)
  end

  def find_project
    @project = current_user.projects.find(params[:id])
  end

  def project_expect_time
    tictac_hour = Task.where(project: @project).sum(:expect_tictacs) * 1500.0 / 3600
    tictac_hour.round(tictac_hour % 10 == 0 ? 0 : 1)
  end
  
end
