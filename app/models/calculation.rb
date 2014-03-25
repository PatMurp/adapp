class Calculation < ActiveRecord::Base
	belongs_to :feedstock
	belongs_to :project


	validates :feedstock_id, presence: true
	validates :tonnes, presence: true

	# newest calculation id displayed at top of list on index page
	scope :newest_first, lambda { order("calculations.created_at DESC") }

	# biogas calculations

	# calculate biogas output from feedstock 
  def calc_m3_biogas (val1 = self.feedstock.biogas_per_tonne, val2 = self.tonnes)
		(val1 * val2).round 2
	end

	# calculate methane output from feedstock
	def calc_m3_ch4 (val1 = self.feedstock.methane_percent, val2 = calc_m3_biogas)
		(val1 * val2).round 2
	end

	# convert methane m3 to kgs 
 	#fixed conversion rate 
 	def calc_kg_ch4 (val1 = 0.73, val2 = calc_m3_ch4)
	 	(val1 * val2).round 2
	end 

	# convert methane m3 to gigajoules
	# fixed conversion rate 
	def calc_gigjoules_ch4 (val1 = 0.03778, val2 = calc_m3_ch4)
		(val1 * val2).round 2 
	end

	# convert methane gigajoules to MWH
	# fixed conversion rate 
	def calc_mwh_ch4 (val1 = calc_gigjoules_ch4, val2 = 3.6)
		(val1 / val2).round 2
	end


	# digestate calculations


  # calculate digestate volumes
  def calc_digestate_tonnes (val1= self.tonnes, val2 = self.feedstock.digestate_percent)
    (val1 * val2).round 2
  end

  # calculate nitrogen volume from digestate
  # assuming 5 kg per tonne
  def calc_digestate_nitrogen (val1 = 0.005, val2 = calc_digestate_tonnes)
    (val1 * val2).round 3
  end

   # calculate phosphorus volume from digestate
  # assuming 0.9 kg per tonne
  def calc_digestate_phosphorus (val1 = 0.0009, val2 = calc_digestate_tonnes)
    (val1 * val2).round 3
  end

  # calculate potash volume from digestate
  # assuming 2.8 kg per tonne
  def calc_digestate_potash (val1 = 0.0028, val2 = calc_digestate_tonnes)
    (val1 * val2).round 3
  end

end
