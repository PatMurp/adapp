class Feedstock < ActiveRecord::Base
	self.inheritance_column = nil

	validates :type, presence: true
	validates :type, uniqueness: { case_sensitive: false } 
	validates :tonnes, presence: true
	validates :biogas_per_tonne, presence: true
	validates :methane_percent, presence: true
	validates :digestate_percent, presence: true
end
