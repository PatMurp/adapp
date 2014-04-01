class ProjectsController < ApplicationController
  before_filter :authenticate_user!
	before_action :set_project, only: [:show, :edit, :update, :destroy, 
                :digestate, :chp, :upgrading, :carbon, :report]

  def index
    @projects = current_user.projects.newest_first
  end

  def new
  	@project = Project.new
    @feedstocks = Feedstock.all
    @project.calculations.build
  end

  def show
  end

  def create
  	@project = Project.new(project_params)
    @project.user_id = current_user.id
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

  def report
  end

  def digestate
  end

  def chp
  end

  def upgrading
  end

  def carbon
  end

  private

  # share common constraints between actions
  def set_project
  	@project = Project.find(params[:id])
  end

  # whitelisted parameters
  def project_params
  	params.require(:project).permit(:name, :user_id,
                                    calculations_attributes: [:id, :tonnes, :feedstock_id, :_destroy])
  end

end

