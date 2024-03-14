require 'app/windows/window_constants.rb'

module WindowTitle
	include WindowConstants

	private
	attr_writer :title

	def initialize_title(given_title)
		self.title = given_title
		resize_to_fit_title
	end

	def title_hash
		{
			x: horizontal_center,
			y: apex[1] - TOP_PADDING,
			text: title,
			size_enum: TITLE_SIZE_ENUM,
			alignment_enum: CENTERED_ENUM,
			line_height: TITLE_LINE_HEIGHT
		}
	end

	def title_line_length
		title.length * TITLE_CHARACTER_WIDTH 
	end

	def title_line_height
		TITLE_LINE_HEIGHT + TOP_PADDING*2
	end

	def resize_to_fit_title
		if title_line_length > width
			self.width = title_line_length + SIDE_PADDING*2
		end

		if title_line_height > self.height
			self.height = title_line_height
		end
	end

	def divider_hash
		{
			x: x,
			x2: apex_x-1, # There's some kind of off-by-one error DragonRuby has with (horizontal?) line primitives.
			y: apex_y-TOP_PADDING*2-TITLE_LINE_HEIGHT,
			y2: apex_y-TOP_PADDING*2-TITLE_LINE_HEIGHT,
			primitive_marker: :line
		}
	end

	def title_section
		[
			title_hash,
			divider_hash
		]
	end

	public
	attr_reader :title

end