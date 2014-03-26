class Project < ActiveRecord::Base

	has_many :calculations, :dependent => :destroy
	accepts_nested_attributes_for :calculations,
	:reject_if => lambda { |a| a[:feedstock_id].blank? }, 
	allow_destroy: true

	
	validates :name, presence: true
	validates :name, uniqueness: { case_sensitive: false }

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

end
