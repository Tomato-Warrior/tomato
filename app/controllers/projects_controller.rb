class ProjectsController < ApplicationController
  before_action :find_project, only: [:edit, :update, :destroy, :show]
  
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
    @undo_tasks = @project.tasks.doing
    @done_tasks = @project.tasks.done
    task_ids = @project.tasks.ids
    @tictac_count = Tictac.where(task_id: task_ids).finished.count
    @expect_time = expect_time
  end

  def destroy
    @project.destroy
    redirect_to root_path, notice: '專案成功刪除喵'
  end

  private

  def project_params
    params.require(:project).permit(:title, :cover)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def expect_time
    tictac_hour = Task.where(project_id: @project).sum(:expect_tictacs) * 1500.0 / 3600
    tictac_hour.round(tictac_hour % 10 == 0 ? 0 : 1)
  end
  
end

