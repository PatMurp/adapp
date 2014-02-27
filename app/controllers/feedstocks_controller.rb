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
		@feedstocks_options = Feedstock.all.map{|f| [ f.type, f.id ] }
		#@feedstocks = Feedstock.all
		@feedstock = Feedstock.new
	end   


	def create
		@feedstock = Feedstock.new()
		@feedstock.tonnes = params[:feedstock][:tonnes]

		if @feedstock.save
      redirect_to @feedstock
    else
      render :new
    end
	end

	def select_tonnes
		params[:some_var]
	end

	def show
		@feedstock = Feedstock.find(params[:id])
		@feedstock_tonnes = @feedstock.tonnes

		@m3_biogas = cal_m3_biogas
		@m3_methane = cal_m3_ch4
		@kg_methane = cal_kg_ch4
		@gj_methane = cal_gigjoules_ch4
		@mwh_methane = cal_mwh_ch4

		@vol_digestate = cal_digestate_tonnes
		@vol_nitrogen = cal_digestate_nitrogen 
		@vol_phosphorus = cal_digestate_phosphorus
		@vol_potash = cal_digestate_potash

		@usable_heat = cal_usable_heat
		@salable_heat = cal_salable_heat
		@heat_value = cal_heat_value

		@potential_elec = cal_potential_elec
		@salable_elec = cal_salable_elec
		@elec_value = cal_elec_value
		@gen_size = cal_generator_size
	end


	def edit
		@feedstock = Feedstock.find(params[:id])
	end

	

	private

	# calculate biogas output from feedstock 
	def cal_m3_biogas val = 101
		#(@biogas_output = @feedstock.tonnes  * val).round 2
		@biogas_output = (@feedstock_tonnes  * val).round 2
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

	# calculate usable heat CHP
	# fixed only half usable
	def cal_usable_heat val = 0.5
		(cal_mwh_ch4 * val).round 2 
	end

	# calculate salable heat CHP
	# fixed only half of usable is salable
	def cal_salable_heat val = 0.5
		(cal_usable_heat * val).round 2 
	end

	# calculate heat value
	# €0.96 per kwh / 1000 for mwh
	# ideally user should be able to set price
	def cal_heat_value val = 0.96 
			(cal_salable_heat * val /1000).round 2
	end

	# calculate potential electricity generated
	# fixed 30% value of available energy
	def cal_potential_elec val = 0.3
		(cal_mwh_ch4 * val).round 2 
	end

	# calculate salable electricity
	# fixed 80% efficiency
	def cal_salable_elec val = 0.8
		(cal_potential_elec * val).round 2 
	end

	# calculate electricity value
	# €130 per kwh / 1000 for mwh
	# ideally user should be able to set price
	def cal_elec_value val = 130
		(cal_salable_elec * val / 1000).round 2
	end

	# calculate required generator size
	def cal_generator_size val = 365 * 24
		(cal_potential_elec / val).round 3
	end
end
