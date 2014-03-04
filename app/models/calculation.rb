class Calculation < ActiveRecord::Base
	belongs_to :feedstock

	validates :feedstock_id, presence: true
	validates :tonnes, presence: true

	# newest calculation id displayed at top of list on index page
	scope :newest_first, lambda { order("calculations.created_at DESC") }

	

	# biogas calculations

	# calculate biogas output from feedstock 
  def cal_m3_biogas val = self.feedstock.biogas_per_tonne
		(self.tonnes  * val).round 2
	end

	# calculate methane output from feedstock
	def cal_m3_ch4 val = self.feedstock.methane_percent
		(cal_m3_biogas * val).round 2
	end

	# convert methane m3 to kgs 
 	#fixed conversion rate 
 	def cal_kg_ch4 val = 0.73
	 	(self.cal_m3_ch4 * val).round 2
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

	# digestate calculations


  # calculate digestate volumes
  def cal_digestate_tonnes val = self.feedstock.digestate_percent
    (@digestate_output = self.tonnes  * val).round 2
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
