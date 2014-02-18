class Feedstock < ActiveRecord::Base
	has_many :substrates

	validates :tonnes, presence: true
end
