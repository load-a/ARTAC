module Identifiable

	@@id_counter = 0
	@@tag = String.new

	def increment_id_counter
		@@id_counter += 1
	end

	def set_class_tag(tag)
		@@tag = tag
	end

	def id_counter
		@@id_counter
	end

	def tag
		@@tag
	end

end