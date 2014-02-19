class FeedstocksController < ApplicationController

	# def biogas
	# 	@feedstocks = Feedstock.all
	# end

	# def substrate

	# end 

	# def digestate
	# end

	def index
		@feedstocks = Feedstock.all
	end

		
	def new
		#@all_feedstocks = Feedstock.all
		@feedstock = Feedstock.new
	end   


	def create
		@feedstock = Feedstock.new()
		@feedstock.tonnes = params[:feedstock][:tonnes]

		
		if @feedstock.save
      redirect_to @feedstock
    else
      render :edit
    end
	end

	def show
		@feedstock = Feedstock.find(params[:id])
		@m3_biogas = cal_m3_biogas
		@m3_methane = cal_m3_ch4
		@kg_methane = cal_kg_ch4
		@gj_methane = cal_gigjoules_ch4
		@mwh_methane = cal_mwh_ch4

		@vol_digestate = cal_digestate_tonnes
		@vol_nitrogen = cal_digestate_nitrogen 
		@vol_phosphorus = cal_digestate_phosphorus
		@vol_potash = cal_digestate_potash
	end


	def edit
		@feedstock = Feedstock.find(params[:id])
	end

	private

	# calculate biogas output from feedstock 
	def cal_m3_biogas val = 101
		(@biogas_output = @feedstock.tonnes  * val).round 2
	end

	# calculate methane output from feedstock
	def cal_m3_ch4 val = 0.6
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

	# calculate digestate volumes
	def cal_digestate_tonnes val = 0.9
		(@digestate_output = @feedstock.tonnes  * val).round 2
	end

	# calculate nitrogen volume from digestate
	# assuming 5 kg per tonne
	def cal_digestate_nitrogen val = 0.005
		(cal_digestate_tonnes * val).round 3
	end

	# calculate phosphorus volume from digestate
	# assuming 0.9 kg per tonne
	def cal_digestate_phosphorus val = 0.0009
		(cal_digestate_tonnes * val).round 3
	end

	# calculate potash volume from digestate
	# assuming 2.8 kg per tonne
	def cal_digestate_potash val = 0.0028
		(cal_digestate_tonnes * val).round 3
	end

end
