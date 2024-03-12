module Update
	extend self

	def classes args
		Mouse.update args
		Mouse.highlight_lattice
		Mouse.highlight_button
		Mouse.interact_with_button		
		Mouse.release_click_buttons

		Keyboard.update args
		Renderer.update args
	end

	def variables args
		args.state.texts ||= []
		args.state.input_buffer ||= String.new

	end

	def objects args
		# Button.all.each { |button| button.resize_to_fit_text }

	end

	def outputs args
		DebugTools.list([50, 700], args.state.texts, args)
		# Renderer.render

		# Mouse-button highlighting
		if Mouse.on_button?
			SELECTOR.remember! Mouse.button if SELECTOR.blank?
		end
		if (SELECTOR.memory.kind_of? Button and !Mouse.on_button?) or (SELECTOR.memory != Mouse.button)
			SELECTOR.memory.unhighlight
			SELECTOR.forget!
		end

	end

end