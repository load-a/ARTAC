def tick args
	initial args if Kernel::tick_count == 0
	Update::variables args
	Update::classes args
	Update::objects args
	Update::outputs args

	args.state.timer ||= CooldownTimer.new('Cooldown Timer', TimeConverter::seconds_to_frames(3))
	args.state.timer_on ||= 1

	args.state.timer.flip! if Keyboard.letter == :space
	args.state.timer.count(auto_restart: true) if args.state.timer.on?

	args.state.frame_input_buffer ||= '0'
	args.state.frame_input_buffer = '0' unless args.state.frame_input_buffer.to_i > 0

	list = [
		args.state.frame_input_buffer,
		args.state.timer.formatted_time,
		"on? " + args.state.timer.status[:on].to_s,
		"State: " + args.state.timer.status[:state].to_s,
	]

	case Keyboard.letter
	when :enter
		args.state.timer.set!(args.state.frame_input_buffer.to_i)
		args.state.frame_input_buffer = '0'
	when :delete
		args.state.frame_input_buffer.chop!
	when :c
		args.state.frame_input_buffer = '0'
	when :space
		args.state.timer_on *= -1
	when :r
		args.state.timer.reset!
	end

	if Keyboard.number?
		args.state.frame_input_buffer = '' if args.state.frame_input_buffer == '0'
		args.state.frame_input_buffer << Keyboard.number.to_s
	end

	DebugTools::list([30, 700], list, args)
	# scaffold_mode args

	# if Mouse.on_button?
	# 	SELECTOR.remember! Mouse.button if SELECTOR.blank?
	# end

	# if (SELECTOR.memory.kind_of? Button and !Mouse.on_button?) or (SELECTOR.memory != Mouse.button)
	# 	SELECTOR.memory.unhighlight
	# 	SELECTOR.forget!
	# end


	
	# Renderer.remove args.state.window if args.state.window.any_true?
	# Renderer.render

end
