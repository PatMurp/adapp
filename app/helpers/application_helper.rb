module ApplicationHelper

	# add commas to large numbers
	def number_delimiter number
		number_with_delimiter(number, delimiter: ",")
	end

	# add percent symbol to end of numbers
	def number_percent number
		number_to_percentage(number, precision: 0)
	end

end
