require 'app/buttons/click_button.rb'
require 'app/geometry/geometry.rb'
require 'app/windows/window_text.rb'

class Window
	include Geometry
	include WindowText

	@@all = []
	class << self
		
		def all
			@@all
		end

	end

	private

	def initialize(title = 'title', body = 'text')
		self.title = title
		self.body = body

		button_section_height = 115

		set_location! [300, 100]
		set_size! [title_length_plus_padding, title_height+body_height+button_section_height]

		@@all << self


		@exit = ClickButton.new(location: [x+5, apex[1]-30], text: "x", size: [25, 25])
		@confirm = ClickButton.new(location: [x+width/8, y+20], text: "Confirm", size: [100, 50])
		@cancel = ClickButton.new(location: [apex[0]-100-width/8, y+20], text: "Cancel", size: [100, 50])
	end

	public
	attr_accessor :title, :body

	def move(new_location)
		dif_x = new_location[0] - x
		dif_y = new_location[1] - y

		set_location!(new_location)

		buttons.each { |button| 
			button.set_location! [button.x + dif_x, button.y + dif_y]
		}
	end


	def primitives
		[rect.merge(Color.black),	divider, button_primitives, texts, background_hash].reverse
	end

	def divider
		{
			x: x,
			y: apex[1]-TITLE_LINE_HEIGHT-TOP_PADDING-BOTTOM_PADDING,
			x2: apex[0]-1,
			y2: apex[1]-TITLE_LINE_HEIGHT-TOP_PADDING-BOTTOM_PADDING,
			primitive_marker: :line
		}
	end

	def background_hash
		background = rect
		background[:primitive_marker] = :solid
		background.merge(Color.white)
	end

	def texts
		[
			title_hash,
			body_hash
		]
	end

	def button_primitives
		buttons.map{|button| button.primitives}
	end

	def buttons
		[
			@exit,
			@confirm,
			@cancel
		]
	end

	def any_true?
		buttons.map {|button| button.true? }.include? true
	end

end