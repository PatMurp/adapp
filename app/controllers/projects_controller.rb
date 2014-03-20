class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
  	@projects = Project.all
  end

  def new
  	@project = Project.new
  end

  def show
  end

  def create
  	@project = Project.new(project_params)
  	if @project.save
  		render action: 'show', location: @project
  	else
  		flash[:error] = "Please enter a Project name"
  		render action: 'new'
  	end
  end

  def edit
  end

  def update
  	if @project.update_attributes(project_params)
  		redirect_to @project
  	else
  		render action: 'edit'
  	end
  end

  def destroy
  	@project.destroy
  	redirect_to(:action => 'index')
  end

  private

  # share common constraints between actions
  def set_project
  	@project = Project.find(params[:id])
  end

  # whitelisted parameters
  def project_params
  	params.require(:project).permit(:name)
  end
end

