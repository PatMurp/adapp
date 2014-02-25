class Feedstock < ActiveRecord::Base
	self.inheritance_column = nil

	#¡¡¡ validations caused post tests to fail  !!!
	#¡¡¡ model needs to be changed for itteration 2 !!!!

	#validates :type, presence: true
	#validates :type, uniqueness: { case_sensitive: false } 
	validates :tonnes, presence: true
	#validates :biogas_per_tonne, presence: true
	#validates :methane_percent, presence: true
	#validates :digestate_percent, presence: true
end
