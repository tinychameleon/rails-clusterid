class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    project = Project.create(project_params)
    if project.save
      redirect_to projects_path
    else
      redirect_to new_project_path(user)
    end
  end

  def update
    @project = Project.find(params[:id])
    user = User.find(ClusterId::V1::Generator.from_friendly(params[:project][:user_id]))
    @project.users << user

    if @project.save
      redirect_to @project
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
