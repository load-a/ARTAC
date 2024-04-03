require 'app/windows/window_constants.rb'

module WindowTitle
	include WindowConstants

	private
	attr_writer :title

	def initialize_title_section(given_title)

		self.title = given_title

		resize_to_fit_title

		section_list << {
			x: x, 
			y: y, 
			w: title_line_width, 
			h: title_line_height,
			section: :title
		}

	end


	def title_section
		[
			divider_hash,
			title_hash
		]
	end

	def divider_hash
		{
			x: self.x,
			x2: apex_x - 1, # There's some kind of off-by-one error DragonRuby makes with [horizontal(?)] line primitives.
			y: apex_y - title_line_height,
			y2: apex_y - title_line_height,
			primitive_marker: :line
		}
	end


	def title_hash
		{
			x: horizontal_center,
			y: apex_y - TOP_PADDING,
			text: title,
			size_enum: TITLE_SIZE_ENUM,
			alignment_enum: CENTERED_ENUM,
			line_height: TITLE_FONT_HEIGHT
		}
	end

	def resize_to_fit_title
		self.width = title_line_width if title_line_width > available_width
		self.height = title_line_height if title_line_height > available_height
	end

	def title_line_width
		title.length * TITLE_CHARACTER_WIDTH + SIDE_PADDING*2
	end

	def title_line_height
		TOP_PADDING + TITLE_FONT_HEIGHT + BOTTOM_PADDING
	end

	public
	attr_reader :title

	def title_rect
		{
			x: self.x,
			y: apex_y - title_line_height,
			w: w,
			h: title_line_height
		}
	end

end