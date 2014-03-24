class Project < ActiveRecord::Base

	has_many :calculations, :dependent => :destroy
	accepts_nested_attributes_for :calculations,
	:reject_if => lambda { |a| a[:feedstock_id].blank? }, 
	allow_destroy: true


	validates :name, presence: true
	validates :name, uniqueness: { case_sensitive: false }

	# newest project is displayed at top of list on index page
	scope :newest_first, lambda { order("projects.created_at DESC") }


end
