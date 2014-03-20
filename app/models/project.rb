class Project < ActiveRecord::Base
	has_many :calculations, :dependent => :destroy
	accepts_nested_attributes_for :calculations

	validates :name, presence: true
end
