class CalculationsController < ApplicationController
  
  def index
  	@calculations = Calculation.newest_first
  end

  def show
  	@calculation = Calculation.find(params[:id])
  end


  def new
  	@calculation = Calculation.new
  	@feedstocks = Feedstock.all
  end

  def create
  	@calculation = Calculation.new(calculation_params)
  	if @calculation.save
  		redirect_to(:action => 'show', :id => @calculation.id)
  	else
  		flash[:error] = "Please ensure a feedstock is selected and a value is entered for tonnes."
  		@feedstocks = Feedstock.all
  		render('new')
  	end
  end

  def edit
  	@calculation = Calculation.find(params[:id])
  	@feedstocks = Feedstock.all
  end

  def update
  	@calculation = Calculation.find(params[:id])
  	if @calculation.update_attributes(calculation_params)
      redirect_to(:action => 'show', :id => @calculation.id)
    else
      @feedstocks = Feedstock.all
      render('edit')
    end
  end

  def destroy
  	@calculation = Calculation.find(params[:id]).destroy
  	redirect_to(:action => 'index')
  end

  private

  def calculation_params
  	params.require(:calculation).permit(:tonnes, :feedstock_id)
  end
end
