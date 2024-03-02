require 'app/buttons/button.rb'

class ClickButton < Button
	def initialize(location, size, text = "CLICK BUTTON")
		super
	end

	def click
		@state = true
		resolve_color
	end

	def release
		@state = false
		resolve_color
	end

end
