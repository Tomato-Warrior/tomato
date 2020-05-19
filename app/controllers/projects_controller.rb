class ProjectsController < ApplicationController
  before_action :find_project, only: [:edit, :update, :destroy, :show]
  
  def index
    project_list if current_user
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to projects_path, notice: 'Project created!'
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project updated!'
    else
      render :edit
    end
  end

  def show
    @task = Task.new
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project deleted!'
  end

  private

  def project_params
    params.require(:project).permit(:project_name, :project_cover)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def project_list
    @projects = current_user.projects
  end

end

