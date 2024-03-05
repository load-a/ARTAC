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
		Mouse.button.to_s, 
	]

	# Commit SCAFFOLD to new Lattice
	args.state.commit ||= ClickButton.new(location: [53, 10], text: "create lattice")	
	if args.state.commit.true? and Level.every(Lattice).empty?
		Lattice.new(SCAFFOLD.location, SCAFFOLD.size.map {|e| e/SCAFFOLD.cell_size}, SCAFFOLD.cell_size)
	end

	# Clear SCAFFOLD
	args.state.clear ||=  ClickButton.new(text: "clear lattice")
	args.state.clear.put_right_of!(args.state.commit)
	args.state.clear.align_vertically_with!(args.state.commit)
	if args.state.clear.true?
		SCAFFOLD.clear!
		Level.delete_every!(Lattice)
	end

	# Change Cell Size
	args.state.cell ||= ClickButton.new(text: "cell size:")
	args.state.cell.put_right_of!(args.state.clear)
	args.state.cell.align_vertically_with!(args.state.commit)
	args.state.cell.set_text!("cell size: " + (args.state.input_buffer == "" ? SCAFFOLD.cell_size.to_s : args.state.input_buffer))
	args.state.cell.release if !Mouse.on?(args.state.click)	and args.state.cell.true?
	if Keyboard.number?
		args.state.input_buffer += Keyboard.number.to_s
	elsif Keyboard.letter == :delete
		args.state.input_buffer.chop!
	elsif Keyboard.letter == :enter and args.state.input_buffer.to_i > 0
		args.state.cell.click
	end
	if args.state.cell.true?
		SCAFFOLD.cell_size = args.state.input_buffer.to_i
		args.state.input_buffer = ""
	end

	# Highlight Mode
	args.state.mode ||= 4
	args.state.highlight ||= ClickButton.new(text: 'mode: 100')
	args.state.highlight.put_right_of!(args.state.cell)
	args.state.highlight.align_vertically_with!(args.state.cell)
	if args.state.highlight.true?
		args.state.mode += 1
		args.state.mode = 0 if args.state.mode > 7
		args.state.highlight.set_text!('mode: %03b' % [args.state.mode])
	end
	Level.every(Lattice)[0].highlight_mode = args.state.mode unless Level.every(Lattice).empty?

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


end
