class Feedstock < ActiveRecord::Base
	has_many :calculations

	self.inheritance_column = nil

	validates :type, presence: true
	validates :type, uniqueness: { case_sensitive: false } # type must be unique
	validates :biogas_per_tonne, presence: true
	validates :methane_percent, presence: true
	validates :digestate_percent, presence: true

	# display feedstocks in alphabetical order
	scope :alphabetical_order, lambda { order("type ASC") }

end
