class Calculation < ActiveRecord::Base
	belongs_to :feedstock

	validates :feedstock_id, presence: true
	validates :tonnes, presence: true
end
