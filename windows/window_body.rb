require 'app/windows/window_constants.rb'

module WindowBody
	include WindowConstants
	private
	attr_accessor :primary_section, :secondary_section

	def initialize_sections(section_one, section_two)

		self.primary_section = section_one
		self.secondary_section = section_two

		@primary_rect = {}
		@primary_content = {}

		@secondary_rect = {}
		@secondary_content = {}

		return if section_one.nil?

		get_primary_hash
		resize_based_on_primary_rect
		update_primary_object_coordinates
		get_primary_content

		return if section_two.nil?

		get_secondary_hash
		resize_based_on_secondary_rect
		update_both_object_coordinates
		get_secondary_content

	end

	def get_primary_hash
		return @primary_rect = primary_section.rect if primary_section.kind_of? TextBlock 
		@primary_rect = primary_section
	end

	def resize_based_on_primary_rect
		if @primary_rect[:w] > self.width - SIDE_PADDING*2
			self.width = @primary_rect[:w] + SIDE_PADDING*2
		end

		if @primary_rect[:h] > self.height - title_line_height - (TOP_PADDING+BOTTOM_PADDING)
			self.height = title_line_height+ @primary_rect[:h] + TOP_PADDING+BOTTOM_PADDING
		end

	end

	def update_primary_object_coordinates(new_y = self.y+BOTTOM_PADDING)
		if primary_section.kind_of? TextBlock
				primary_section.set_location! [self.x+SIDE_PADDING, new_y]
		else
			@primary_rect[:x] = self.x + SIDE_PADDING
			@primary_rect[:y] = new_y
		end
	end

	def get_primary_content
		if primary_section.kind_of? TextBlock
			@primary_content = primary_section.primitives 
		else
			@primary_content = primary_section
		end
	end

	def get_secondary_hash
		if secondary_section.kind_of? TextBlock 
			@secondary_rect = secondary_section.rect 
		else
			@secondary_rect = secondary_section
		end
	end

	def resize_based_on_secondary_rect
		if @secondary_rect[:w] > self.width - SIDE_PADDING*2
			self.width = @secondary_rect[:w] + SIDE_PADDING*2
		end

		if @secondary_rect[:h] > self.height - title_line_height - (@primary_rect[:h]+TOP_PADDING+BOTTOM_PADDING) - (TOP_PADDING+BOTTOM_PADDING)
			self.height = title_line_height + (@primary_rect[:h]+TOP_PADDING+BOTTOM_PADDING) + (@secondary_rect[:h]+BOTTOM_PADDING)
		end
	
	end

	def update_both_object_coordinates

		if secondary_section.kind_of? TextBlock
			self.secondary_section.set_location! [ self.x+SIDE_PADDING, self.y+BOTTOM_PADDING]
		else
			@secondary_rect[:x] = self.x + SIDE_PADDING
			@secondary_rect[:y] = self.y + BOTTOM_PADDING
		end

		update_primary_object_coordinates(self.y+BOTTOM_PADDING+@secondary_rect[:h]+TOP_PADDING)

		get_primary_content
		get_secondary_content
	end

	def get_secondary_content
		if secondary_section.kind_of? TextBlock
			@secondary_content = secondary_section.primitives 
		else
			@secondary_content = secondary_section
		end
	end


	def body_sections
		return if @primary_content.empty?
		[
			@primary_content,
			(@secondary_content unless @secondary_content.empty?)
		]
	end	

end