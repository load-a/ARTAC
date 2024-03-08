require 'app/buttons/click_button.rb'
require 'app/geometry/geometry.rb'
require 'app/windows/window_text.rb'

class Window
	include Geometry
	include WindowText

	private

	def initialize(title = 'title', body = 'text')
		self.title = title
		self.body = body

		button_section_height = 115

		set_location! [300, 100]
		set_size! [title_length_plus_padding, title_height+body_height+button_section_height]


		@exit = ClickButton.new(location: [x+5, apex[1]-30], text: "x", size: [25, 25])
		@confirm = ClickButton.new(location: [x+width/8, y+20], text: "Confirm", size: [100, 50])
		@cancel = ClickButton.new(location: [apex[0]-100-width/8, y+20], text: "Cancel", size: [100, 50])
	end

	public
	attr_accessor :title, :body

	def primitives
		[rect.merge(Color.black), buttons, texts, background_hash].reverse
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

	def buttons
		[
			@exit,
			@confirm,
			@cancel
		].map{|button| button.primitives}
	end
end