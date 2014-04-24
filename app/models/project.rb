class Project < ActiveRecord::Base

	has_many :calculations, :dependent => :destroy
	accepts_nested_attributes_for :calculations,
	:reject_if => lambda { |a| a[:feedstock_id].blank? }, 
	allow_destroy: true
	belongs_to :user

	
	validates :name, presence: true

	# newest project is displayed at top of list on index page
	scope :newest_first, lambda { order("projects.created_at DESC") }


	# biogas totals

	# calculate feedstock tonnes total
	def total_tonnes
		(calculations.collect(&:tonnes).sum).round 2
	end

	# calculate m3 of biogas total
	def total_m3_biogas
		(calculations.collect(&:calc_m3_biogas).sum).round 2
	end

	# calculate m3 of methane total
	def total_m3_ch4
		(calculations.collect(&:calc_m3_ch4).sum).round 2
	end

	# calculate kgs methane total
	def total_kg_ch4
		(calculations.collect(&:calc_kg_ch4).sum).round 2
	end

	# calculate total gigajoules 
	def total_gigjoules_ch4
		(calculations.collect(&:calc_gigjoules_ch4).sum).round 2
	end

	# calculate total  MWH 
	def total_mwh_ch4
		(calculations.collect(&:calc_mwh_ch4).sum).round 2
	end

	# digestate totals

	# calculate total digestate volume in tonnes
	def total_digestate_tonnes
		(calculations.collect(&:calc_digestate_tonnes).sum).round 2
	end

	# calculate total nitrogen tonnes
	def total_digestate_nitrogen
		(calculations.collect(&:calc_digestate_nitrogen).sum).round 3
	end

	# calculate total phosphorus tonnes
	def total_digestate_phosphorus
		(calculations.collect(&:calc_digestate_phosphorus).sum).round 3
	end

	# calculate total potash tonnes
	def total_digestate_potash
		(calculations.collect(&:calc_digestate_potash).sum).round 3
	end

	# CHP calculations

	# calculate usable heat
	# fixed conversion rate 0.5
	def chp_usable_heat(val1 = total_mwh_ch4, val2 = 0.5)
		(val1 * val2).round 2
	end

	# calculate salable heat
	# fixed conversion rate 0.5
	def chp_salable_heat(val1= chp_usable_heat, val2 = 0.5)
		(val1 * val2).round 2
	end

	# calculate carbon displaced for chp heat
	# fixed value primary factor 1.1
	# fixed value emission factor 0.272
	def calc_carbon_savings_from_chp_heat(val1= chp_salable_heat, val2= 1.1, val3= 0.272)
		(val1 * val2 * val3).round 2
	end

	# calculate potential income 
	# €0.096 per kwh * 1000 for mwh
	# ideally user should be able to set price
	def calc_potential_income_heat(val1= chp_salable_heat, val2= 96)
		(val1 * val2).round 2
	end

	# calculate usable electriciy
	# fixed 30% value of available energy
	def chp_potential_elec(val1 = total_mwh_ch4, val2 = 0.3)
		(val1 * val2).round 2
	end

	# calculate salable electricity
	# fixed 80% efficiency
	def chp_salable_elec(val1= chp_potential_elec, val2= 0.8)
		(val1 * val2).round 2
	end

	# calculate carbon displaced by chp elec
	# fixed value primary factor = 2.7
	# fixed value emission factor = 0.643
	def calc_carbon_savings_from_chp_elec(val1= chp_salable_elec, val2= 2.7, val3= 0.643)
		(val1 * val2 * val3).round 2
	end

	# calculate conbined chp carbon displaced
	def calc_carbon_savings_from_chp_combined(val1= calc_carbon_savings_from_chp_heat,
																						val2= calc_carbon_savings_from_chp_elec)
		(val1 + val2).round 2
	end

	# calculate required generator size
	# hours in year
	def calc_generator_size(val1= chp_salable_elec, val2 = 364 * 24)
		(val1 / val2).round 3
	end

	# price per MWh
	# Ireland tariffs
	# if generator size less than 0.5 price €150
	# otherwise price is €130
	def elec_price(val1= 150, val2= 130,  val3=calc_generator_size)
		if val3 <= 0.5
			val1
		else
			val2
		end
	end

	# calculate potential elec income
	def calc_potential_income_elec(val1= chp_salable_elec, val2= elec_price)
		(val1 * val2).round 2
	end

	# calculate total chp potential income
	def calc_total_potential_income_chp(val1= calc_potential_income_heat, val2= calc_potential_income_elec)
		val1 + val2
	end

	# upgrading calculations

	# calculate energy consumption MWh
	# assumed 3.1
	def calc_upg_energy_consump(val1= total_m3_ch4, val2= 3.15 / 1000)
		(val1 * val2).round 2
	end

	# calculate upgrading ch4 loss
	# fixed value 3.35%
	def calc_upg_ch4_loss(val1= total_m3_ch4, val2= 0.0335)
		(val1 * val2).round 2
	end

	# calculate upgraded ch4
	def calc_upg_ch4(val1=total_m3_ch4, val2=  calc_upg_ch4_loss)
		(val1 - val2).round 2
	end

	# convert upgraded methane m3 to gigajoules
	# fixed conversion rate 
	def calc_upg_gigjoules_ch4 (val1 = 0.03778, val2 = calc_upg_ch4)
		(val1 * val2).round 2 
	end

	# calculate ch4 upgraded per hour
	def calc_upg_ch4_per_hour(val1= calc_upg_ch4, val2= 364 * 24)
		(val1 / val2).round 2
	end

	# calculate potential vehicle fuel value
	def calc_potential_upg_income_vehicle(val1= calc_upg_ch4, val2= 0.81)
		(val1 * val2).round 2
	end

	# calculate potential number of buses fueled
	def calc_potential_buses_fueled(val1= calc_upg_ch4, val2= 27500)
		(val1 / val2).round 1
	end

	# calculate potential number of refuse trucks fueled
	def calc_potential_wtruck_fueled(val1= calc_upg_ch4, val2= 35750)
		(val1 / val2).round 1
	end

	# calculate potential number of refuse trucks fueled
	def calc_potential_cars_fueled(val1= calc_upg_ch4, val2= 1035)
		(val1 / val2).round 1
	end

	# calculate therms of upgraded methane
	def calc_upg_therms(val1= calc_upg_gigjoules_ch4, val2= 9.4781708)
		(val1 * val2).round 2
	end

	# calculate potential value of wholesale gas grid sales
	def calc_potential_gas_grid_income(val1= calc_upg_therms, val2= 0.96)
		(val1 * val2).round 2
	end

	# calculate potential mwh upgraded methane
	def calc_upg_mwh_ch4(val1= calc_upg_gigjoules_ch4, val2= 3.6)
		(val1 / val2).round 2
	end

	# calculate potential number of private homes fueled
	# assume annual gas use is 13800 kwh or 1.38 mwh
	def calc_potential_homes_fueled(val1= calc_upg_mwh_ch4, val2= 13.8)
		(val1 / val2).round 1
	end

	# calculate potential carbon displaced from gas grid
	# fixed primary factor = 1.1
	# fixed emission factor = 0.203
	def calc_carbon_savings_from_upg_ggrid(val1= calc_upg_mwh_ch4, val2= 1.1, val3= 0.203)
		(val1 * val2 * val3).round 2
	end

	# calculate potential carbon displaced using fuel diesel
	# fixed kg Co2/mwh = 0.2938
	# fixed emissions reduction 78% = 0.78
	def calc_carbon_savings_from_upg_diesel(val1= calc_upg_mwh_ch4, val2= 0.2938, val3= 0.78)
		(val1 * val2 * val3).round 2
	end

end
