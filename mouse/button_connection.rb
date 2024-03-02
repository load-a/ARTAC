


module ButtonConnection

	def current_button
		return unless on_any_in? Button.all
		Mouse.sees_in_list(Button.all)[0]
	end
	alias button current_button

	def on_button?
		!current_button.nil?
	end

	def click_button
		current_button.click
	end

	def press_button
		current_button.click if current_button.kind_of? ClickButton
		current_button.toggle if current_button.kind_of? ToggleButton		
	end

	def release_button
		return if current_button.kind_of? ToggleButton
		current_button.release
	end

	def hold_button
		if click?
			press_button 
		elsif held? and current_button.kind_of? ClickButton
			click_button
		end
		button.use_secondary_background_color
	end

	def toggle_button
		return if current_button.kind_of? ClickButton
		current_button.toggle
	end

	# not implemented yet
	# def highlight_button
	# 	current_button.highlight
	# end

end