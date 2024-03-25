require 'app/windows/window_constants.rb'

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

module WindowBody
	include WindowConstants

	private
	attr_accessor :all_content_objects

	def initialize_content_sections(content_objects)
		content_objects = [content_objects] unless content_objects.kind_of? Array

		self.all_content_objects = []

		content_objects.each_with_index { |object, index|
			content = Content.new(object, index)

			resize_to_fit_content(content) 
			relocate_content(content)

			section_list << content.generate_list_hash(title)
			self.all_content_objects << object
		}

	end

	def resize_to_fit_content(content)
		resize_width(content)
		resize_height(content)
	end

	def resize_width(content)
		self.width = content.boundaries[:w] + SIDE_PADDING*2 if content.boundaries[:w] > available_width
	end

	def resize_height(content)
		content_height = content.boundaries[:h]+TOP_PADDING

		all_content_objects.each { |item|
			item.move_location! [0, content_height]
		}
		
		self.height += content_height
	end


	def relocate_content(content)
		new_x = self.x + SIDE_PADDING
		new_y = section_list.last[:y]# - TOP_PADDING - content.boundaries[:h]
		content.set_location! [new_x, new_y]
	end

	def move_contents(new_relative_location)
		all_content_objects.each { |content|
			content.move_location! new_relative_location
		}
	end

	def content_section
		all_content_objects.map { |content|
			content.primitives
		}
	end

end

