require 'app/geometry/geometry.rb'
require 'app/colors/color.rb'

class Button
	#comment
	include Geometry

	@@id = 0
	@@all = []

	class << self

		def all
			@@all
		end

		def all_primitives
			all.map { |button| button.primitives }
		end

		def formatted_info
			'Btn (%d)' % [all.length]
		end
		alias info formatted_info

	end

	
		
	private
		

	def initialize(location, size, text = "BUTTON")
		set_dimensions!(location, size)

		@state = false
		@text = text

		@text_color = Color.black
		@border_color = Color.black

		@primary_background_color = Color.white
		@primary_background_transparancy = {a: 256}

		@secondary_background_color = Color.grey		
		@secondary_background_transparancy = {a: 128}

		@highlight_background_color = Color.blue
		@highlight_background_transparancy = {a: 32}

		@background_color = @primary_background_color
		@background_transparancy = @primary_background_transparancy

		@id = @@id

		@@id += 1 
		@@all << self
	end

	public
	attr_reader :state, :id

	def primitives
		[rect.merge(@border_color), text_hash, background_hash].reverse
	end

	def text_hash
		{
			x: horizontal_center,
			y: vertical_center,
			text: @text,
			primitive_marker: :label,
			alignment_enum: 1,
			vertical_alignment_enum: 1
		}.merge(@text_color)
	end

	def background_hash
		background = rect
		background[:primitive_marker] = :solid
		background.merge(@background_color).merge(@background_transparancy)
	end

	def use_primary_background_color
		@background_color = @primary_background_color
	end

	def use_secondary_background_color
		@background_color = @secondary_background_color
	end

	def use_highlight_background_color
		@background_color = @highlight_background_color
	end


	def use_primary_background_transparancy
		@background_transparancy = @primary_background_transparancy
	end

	def use_secondary_background_transparancy
		@background_transparancy = @secondary_background_transparancy
	end

	def use_highlight_background_transparancy
		@background_transparancy = @highlight_background_transparancy
	end


	def set_text
		@text
	end

	# #note This assumes font size is 10p wide
	def resize_to_fit_text(padding = 10)
		text_length = (@text.length*10 + padding*2)
		if (text_length <=> width) != 0
			self.width = text_length
		end
	end

	def highlight
		use_highlight_background_color
		use_highlight_background_transparancy
	end

	def resolve_color
		if state
			use_secondary_background_color
			use_secondary_background_transparancy

		else
			use_primary_background_color
			use_primary_background_transparancy

		end
	end
	alias unhighlight resolve_color

	def true?
		state == true
	end

	def false?
		state == false
	end

end