def tick args
	initial args if Kernel::tick_count == 0
	Update::variables args
	Update::classes args
	Update::objects args
	Update::outputs args

	val = case Keyboard.direction_held
	when :down
		"asdfasdfa"
	when :left
		"123412314"
	else 
		false
	end

	texts = [
		Keyboard.held_inputs,
		Keyboard.direction_held,
		val
	]

	DebugTools.list([10, 700], texts, args)

	# args.state.color_table ||= Window.new([100, 100],'', 0)

	# scaffold_mode args

	
	# Renderer.remove args.state.window if args.state.window.any_true?
	# Renderer.render

end
