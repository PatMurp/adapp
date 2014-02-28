class CalculationsController < ApplicationController
  
  def index
  	@calculations = Calculation.all
  end

  def show
  	@calculation = Calculation.find(params[:id])

  	@m3_biogas = cal_m3_biogas
		@m3_methane = cal_m3_ch4
		@kg_methane = cal_kg_ch4
		@gj_methane = cal_gigjoules_ch4
		@mwh_methane = cal_mwh_ch4
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

	# calculate biogas output from feedstock 
	def cal_m3_biogas val = @calculation.feedstock.biogas_per_tonne
		@biogas_output = (@calculation.tonnes  * val).round 2
	end

	# calculate methane output from feedstock
	def cal_m3_ch4 val = @calculation.feedstock.methane_percent
		(cal_m3_biogas * val).round 2
	end

	# convert methane m3 to kgs 
	# fixed conversion rate 
	def cal_kg_ch4 val = 0.73
		(cal_m3_ch4 * val).round 2
	end 

	# convert methane m3 to gigajoules
	# fixed conversion rate 
	def cal_gigjoules_ch4 val = 0.03778
		(cal_m3_ch4 * val).round 2 
	end

	# convert methane gigajoules to MWH
	# fixed conversion rate 
	def cal_mwh_ch4 val = 3.6
		(cal_gigjoules_ch4 / val).round 2
	end
  
end
