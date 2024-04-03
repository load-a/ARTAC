class Content

	attr_accessor :content_object, :id
	def initialize(content_object, id)
		self.content_object = content_object
		self.id = id
	end

	def set_location!(new_location)
		content_object.set_location! new_location
	end

	def move_location!(new_relative_location)
		content_object.move! new_relative_location
	end

	def boundaries
		content_object.rect
	end

	def primitives
		content_object.primitives
	end

	def generate_list_hash(title)
		list_hash = boundaries
		list_hash[:section] = "#{title}_content_" + id.to_s
		list_hash
	end

end
