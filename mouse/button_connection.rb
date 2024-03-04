require 'app/buttons/button.rb'

module ButtonConnection

	def current_button
		return unless on_any_in? Button.all
		Mouse.sees_in_list(Button.all)[0]
	end
	alias button current_button

	def on_button?
		!current_button.nil?
	end

	def interact_with_button
		if Mouse.click?
			current_button.hold if current_button.kind_of? HoldButton
			current_button.click if current_button.kind_of? ClickButton
			current_button.toggle if current_button.kind_of? ToggleButton		
		elsif Mouse.hold?
			current_button.hold if current_button.kind_of? HoldButton
		elsif Mouse.up?
			current_button.release unless current_button.kind_of? ToggleButton
		end
	end

	def highlight_button
		Mouse.current_button.highlight
	end


	# not implemented yet
	# def highlight_button
	# 	current_button.highlight
	# end

end