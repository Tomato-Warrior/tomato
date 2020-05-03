class ProjectsController < ApplicationController
  before_action :find_project, only: [:edit, :update, :destroy]
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user 

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
  end

  def destroy
    @project.destroy
    redirect_to project_path, notice: 'Project deleted!'
  end

  private

  def project_params
    params.require(:project).permit(:project_name)
  end

  def find_project
    @project = Project.find(params[:id])
  end

end

