module ApplicationHelper

	# helper for adding calculation fields in project form
	def link_to_add_fields(name, f, association)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize + "_fields", f: builder)
		end
		link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	end

	# add commas to large numbers
	def number_delimiter number
		number_with_delimiter(number, delimiter: ",")
	end

	# add percent symbol to end of numbers
	def number_percent number
		number_to_percentage(number, precision: 0)
	end

	# format numbers with euro symbol
	def number_euro number
		number_to_currency(number, locale: :ie)
	end

	# navbar link is highlighed when page is active
	def is_active?(link_path)
	  if current_page?(link_path)
	    "active"
	  else
	    ""
	  end
 end

end
