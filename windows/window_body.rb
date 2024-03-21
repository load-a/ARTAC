require 'app/windows/window_constants.rb'

class Content

	attr_accessor :content, :id
	def initialize(content_object, id)
		self.content = content_object
		self.id = id
	end

	def set_location!(new_location)
		content.set_location! new_location
	end

	def move_location!(new_relative_location)
		content.move! new_relative_location
	end

	def boundaries
		content.rect
	end

	def primitives
		content.primitives
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

		self.all_content_objects = content_objects

		all_content_objects.each_with_index { |object, index|
			content = Content.new(object, index)

			resize_to_fit_content(content) 
			relocate_content(content)

			section_list << content.generate_list_hash(title)
		}

	end

	def resize_to_fit_content(content)
		self.width = content.boundaries[:w] + SIDE_PADDING*2 if content.boundaries[:w] > available_width
		if content.boundaries[:h] > available_height
			self.height += content.boundaries[:h] + TOP_PADDING 
			# I need to figure out a way to push everything else up if a new item is added to the bottom of the window
			# Maybe a #raise_everything_by(number) in the Window class
			# Or change the window's anchor point to the top left?
		end
	end

	def relocate_content(content)
		new_x = self.x + SIDE_PADDING
		new_y = section_list.last[:y]# - TOP_PADDING - content.boundaries[:h]
puts section_list.last
		content.set_location! [new_x, new_y]
		puts content.generate_list_hash(title)


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

