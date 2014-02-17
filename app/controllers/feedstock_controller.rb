class FeedstockController < ApplicationController

	def biogas
	end

	def substrate
		@substrates = Substrate.all
	end 

	def digestate
	end
	
end
