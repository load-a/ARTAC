class TextBlock
	include Perimeter

	LINE_HEIGHT = 25
	CHARACTER_WIDTH = 10
	# Character height is 20
	DEFAULT_COLUMN_LIMIT = 40

	def initialize(text, number_of_columns = DEFAULT_COLUMN_LIMIT)

		if text.kind_of? String
			text = [text]
		end

		@raw_text = text
		@column_limit = number_of_columns

		set_location! [0, 0]
		set_size! [@column_limit*CHARACTER_WIDTH, text_block_height]
	end


	public
	attr_accessor :y

	def set_location! new_location
		self.x = new_location[0]
		self.y = new_location[1] #+ text_block_height
	end

	def text_block_height
		text_array.length * LINE_HEIGHT
	end

	def text_hash
		text_array.map_with_index { |text, index|
			{
				x: horizontal_center,
				y: apex_y - LINE_HEIGHT*index,
				text: text,
				alignment_enum: CENTERED_ENUM,
				vertical_alignment_enum: 2,
				primitive_marker: :label,
			}
		}
	end
	alias primitives text_hash

	def text_array
		@raw_text.map { |line|
			wrap_text(line)
		}.flatten
	end

	def text_block_height
		text_array.length * LINE_HEIGHT
	end


	def wrap_text(line)
		new_text = []
		new_line = ""

		line.split(' ').each { |word|
			if word.length + 1 + new_line.length > @column_limit
				new_text << new_line
				new_line = ''
			end
			new_line += word + ' '
		}

		new_text << new_line
		new_text

	end


end