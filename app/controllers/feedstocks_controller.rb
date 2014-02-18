class FeedstocksController < ApplicationController

	# def biogas
	# 	@feedstocks = Feedstock.all
	# end

	# def substrate

	# end 

	# def digestate
	# end

	def index
		@feedstocks = Feedstock.all
	end

		
	def new
		@feedstock = Feedstock.new
		#@substrate = @feedstock.substrate
	end   


	def create
		@feedstock = Feedstock.new()
		@feedstock.tonnes = params[:feedstock][:tonnes]

		if @feedstock.save
      redirect_to @feedstock
    else
      render :edit
    end
	end

	def show
		@feedstock = Feedstock.find(params[:id])
	end


	def edit
		@feedstock = Feedstock.find(params[:id])
	end

	
end
