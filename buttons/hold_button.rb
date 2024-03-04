require 'app/buttons/button.rb'

class HoldButton < Button
	def initialize(location, size, text = "HOLD BUTTON")
		super
	end

	def hold
		@state = true
		resolve_color
	end

	def release
		@state = false
		resolve_color
	end
	
end