class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destroy, :digestate]

  def index
  	@projects = Project.newest_first
  end

  def new
  	@project = Project.new
    @feedstocks = Feedstock.all
    #3.times { @project.calculations.build }
    @project.calculations.build
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
    @feedstocks = Feedstock.all
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

  def digestate
  end

  private

  # share common constraints between actions
  def set_project
  	@project = Project.find(params[:id])
  end

  # whitelisted parameters
  def project_params
  	params.require(:project).permit(:name,
                                    calculations_attributes: [:id, :tonnes, :feedstock_id, :_destroy])
  end
end

