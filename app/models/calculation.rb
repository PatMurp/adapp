class Calculation < ActiveRecord::Base
	belongs_to :feedstock

	validates :feedstock_id, presence: true
	validates :tonnes, presence: true

	# calculate biogas output from feedstock 
	# def self.cal_m3_biogas val = @calculation.feedstock.biogas_per_tonne
	# 	(@calculation.tonnes  * val).round 2
	# end

end
