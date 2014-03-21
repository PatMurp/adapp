class Project < ActiveRecord::Base

	has_many :calculations, :dependent => :destroy
	accepts_nested_attributes_for :calculations


	validates :name, presence: true

	# newest project is displayed at top of list on index page
	scope :newest_first, lambda { order("projects.created_at DESC") }

end
