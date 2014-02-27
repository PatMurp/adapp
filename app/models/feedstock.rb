class Feedstock < ActiveRecord::Base
	has_many :calculations
	self.inheritance_column = nil

	validates :type, presence: true
	validates :type, uniqueness: { case_sensitive: false } 
	validates :biogas_per_tonne, presence: true
	validates :methane_percent, presence: true
	validates :digestate_percent, presence: true
end
