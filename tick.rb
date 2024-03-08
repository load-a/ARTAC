def tick args
	Update::variables args
	Update::classes args
	Update::objects args
	Update::outputs args

	args.state.texts = [ 
		Mouse.formatted_info, 
		SCAFFOLD.formatted_info, 
		Level.formatted_info, 
		Button.info, 
		args.state.window
	]

	# Commit SCAFFOLD to new Lattice
	if ClickButton::commit_lattice.true? and Level.every(Lattice).empty?
		Lattice.new(SCAFFOLD.location, SCAFFOLD.size.map {|e| e/SCAFFOLD.cell_size}, SCAFFOLD.cell_size)
	end

	# Clear SCAFFOLD
	ClickButton::clear_lattice.put_right_of!(ClickButton::commit_lattice)
	ClickButton::clear_lattice.align_vertically_with!(ClickButton::commit_lattice)
	if ClickButton::clear_lattice.true?
		SCAFFOLD.clear!
		Level.delete_every!(Lattice)
	end

	# Change Cell Size
	ClickButton::cell_size.put_right_of!(ClickButton::clear_lattice)
	ClickButton::cell_size.align_vertically_with!(ClickButton::commit_lattice)
	ClickButton::cell_size.set_text!("cell size: " + (args.state.input_buffer == "" ? SCAFFOLD.cell_size.to_s : args.state.input_buffer))
	ClickButton::cell_size.release if !Mouse.on?(args.state.click)	and ClickButton::cell_size.true?
	if Keyboard.number?
		args.state.input_buffer += Keyboard.number.to_s
	elsif Keyboard.letter == :delete
		args.state.input_buffer.chop!
	elsif Keyboard.letter == :enter and args.state.input_buffer.to_i > 0
		ClickButton::cell_size.click
	end
	if ClickButton::cell_size.true?
		SCAFFOLD.cell_size = args.state.input_buffer.to_i
		args.state.input_buffer = ""
	end

	# Highlight Mode
	args.state.mode ||= 4
	ClickButton::mode_cycle.put_right_of!(ClickButton::cell_size)
	ClickButton::mode_cycle.align_vertically_with!(ClickButton::cell_size)
	if ClickButton::mode_cycle.true?
		args.state.mode += 1
		args.state.mode = 0 if args.state.mode > 7
		ClickButton::mode_cycle.set_text!('mode: %03b' % [args.state.mode])
	end
	Level.every(Lattice)[0].highlight_mode = args.state.mode unless Level.every(Lattice).empty?

	# Mode/Layer Shift
	ClickButton::previous_mode.put_left_of! ClickButton::next_mode
	ClickButton::previous_mode.align_vertically_with! ClickButton::next_mode

	scaffold_mode args

	if Mouse.on_button?
		SELECTOR.remember! Mouse.button if SELECTOR.blank?
	end

	if Mouse.on_lattice? and (args.state.mode > 0) and !(Mouse.x > 1050 and Mouse.y > 510)
		$gtk.hide_cursor
	else
		$gtk.show_cursor
	end

	if (SELECTOR.memory.kind_of? Button and !Mouse.on_button?) or (SELECTOR.memory != Mouse.button)
		SELECTOR.memory.unhighlight
		SELECTOR.forget!
	end

	if Keyboard.letter_hold == :shift
		args.outputs.borders << {
			x: SCAFFOLD.anchor_point[0] - 6, 
			y: SCAFFOLD.anchor_point[1] - 6, 
			w: 12, 
			h: 12
		}.merge(Color.red)
	end



	args.state.window ||= Window.new('An Old Pond - Matsuo Basho', ['Furu ike ya','kawazu tobikomu','mizu no oto'])
	args.outputs.primitives << args.state.window.primitives


end
