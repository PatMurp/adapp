class Substrate < ActiveRecord::Base
	belongs_to :feedstock
	self.inheritance_column = nil
end
