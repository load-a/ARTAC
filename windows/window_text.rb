module WindowText
	private 

	TOP_PADDING = 20
	SIDE_PADDING = 35

	TITLE_LINE_HEIGHT = 20
	TITLE_SIZE_ENUM = 3
	TITLE_CHARACTER_WIDTH = 13

	BODY_LINE_HEIGHT = 25
	BODY_CHARACTER_WIDTH = 10
	# Character height is 20
	BODY_CHARACTER_MINIMUM = 40
	BODY_CHARACTER_PADDING = 4

	RIGHT_ALIGNED = 0
	CENTERED = 1
	LEFT_ALIGNED = 2

	public

	def title_hash
		{
			x: horizontal_center,
			y: apex[1] - TOP_PADDING,
			text: title,
			size_enum: TITLE_SIZE_ENUM,
			alignment_enum: CENTERED,
			line_height: TITLE_LINE_HEIGHT
		}
	end

	def title_height
		TOP_PADDING + TITLE_LINE_HEIGHT
	end

	def title_length_plus_padding
		[ (title.length*TITLE_CHARACTER_WIDTH + SIDE_PADDING*2), BODY_CHARACTER_MINIMUM*BODY_CHARACTER_WIDTH ].max
	end

	def body_hash
		fix_text.map_with_index { |text, index|
			{
				x: horizontal_center,
				y: title_hash[:y] - title_hash[:line_height] - (BODY_LINE_HEIGHT * (index+1)),
				text: text,
				alignment_enum: CENTERED,
				line_height: BODY_LINE_HEIGHT
			}
		}
	end

	def body_height
		fix_text.length * BODY_LINE_HEIGHT
	end

	def fix_text
		new_text = []
		new_line = ""

		body.split(' ').each { |word|
			if word.length + 1 + new_line.length > title_length_plus_padding/BODY_CHARACTER_WIDTH - BODY_CHARACTER_PADDING
				new_text << new_line
				new_line = ''
			end
			new_line += word + ' '
		}
		new_text << new_line
		new_text

	end

end