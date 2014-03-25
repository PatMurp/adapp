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

end
