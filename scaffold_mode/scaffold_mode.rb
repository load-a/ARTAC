require 'app/scaffold_mode/_scaffold.rb'
require 'app/scaffold_mode/scaffold_interaction.rb'

def scaffold_mode args

	Renderer.add SCAFFOLD
	Button.all.each { |button| Renderer.add button}

	args.state.texts = [ 
	]

	args.state.input_buffer ||= ''

	# Commit SCAFFOLD to new Grid
	if ClickButton::commit_grid.true? and Level.every(Grid).empty?
		Renderer.add( Grid.new(SCAFFOLD.location, SCAFFOLD.size.map {|e| e/SCAFFOLD.cell_size}, SCAFFOLD.cell_size) )
	end

	# Clear SCAFFOLD
	ClickButton::clear_grid.put_right_of!(ClickButton::commit_grid)
	ClickButton::clear_grid.align_vertically_with!(ClickButton::commit_grid)
	if ClickButton::clear_grid.true?
		SCAFFOLD.clear!
		Renderer.remove( Level.every(Grid)[0] )
		Level.delete_every!(Grid)
	end

	# Change Cell Size
	ClickButton::cell_size.put_right_of!(ClickButton::clear_grid)
	ClickButton::cell_size.resize_to_fit_text
	ClickButton::cell_size.align_vertically_with!(ClickButton::commit_grid)
	ClickButton::cell_size.set_text!("cell size: " + (args.state.input_buffer == "" ? SCAFFOLD.cell_size.to_s : args.state.input_buffer))
	ClickButton::cell_size.release if !Mouse.on?(args.state.click)	and ClickButton::cell_size.true?
	if Keyboard.number?
		args.state.input_buffer += Keyboard.numeral[0].to_s
	elsif Keyboard.letter.include? :backspace
		args.state.input_buffer.chop!
	elsif Keyboard.letter.include? :enter and args.state.input_buffer.to_i > 0
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
	Level.every(Grid)[0].highlight_mode = args.state.mode unless Level.every(Grid).empty?

	# Mode/Layer Shift
	ClickButton::previous_mode.put_left_of! ClickButton::next_mode
	ClickButton::previous_mode.align_vertically_with! ClickButton::next_mode

	if Mouse.click? && !Mouse.on_button? && !Mouse.on_any_in?( Renderer.all.select {|object| object.kind_of? Window})
		if Keyboard.letter_hold.include? :shift
			# Do nothing
		elsif Keyboard.letter_hold.include? :space
			ScaffoldInteraction::bind_scaffold_location_to_mouse_location
		else
			ScaffoldInteraction::reset_scaffold_to_mouse_location
		end

	elsif Mouse.held? && !Mouse.on_button? && !Mouse.on_any_in?( Renderer.all.select {|object| object.kind_of? Window})
		if Keyboard.letter_hold.include? :space
			SCAFFOLD.adjust_location_with_difference(Mouse.location)

		else
			SCAFFOLD.calculate_size_from_reference(Mouse.location)
			SCAFFOLD.extend_non_negative_dimensions
			args.outputs.solids << {
				x: SCAFFOLD.anchor_point[0] - 6, 
				y: SCAFFOLD.anchor_point[1] - 6, 
				w: 12, 
				h: 12,
				a: 128
			}.merge(Color.blue)
		end

	elsif Mouse.up? or Keyboard.letter_up.include? :shift
		if Keyboard.letter_hold.include? :shift
			# Do nothing
		else
			SCAFFOLD.reposition_anchor_if_dimensions_are_negative 
			SCAFFOLD.change_anchor_to_match_location
		end
	
	end

	# Resize scaffold anchor location
	if Keyboard.letter_hold.include? :shift
		args.outputs.borders << {
			x: SCAFFOLD.anchor_point[0] - 6, 
			y: SCAFFOLD.anchor_point[1] - 6, 
			w: 12, 
			h: 12
		}.merge(Color.red)
	end

	# Hide mouse if on a highlighted Grid
	if Mouse.on_grid? and (args.state.mode > 0) and !(Mouse.x > 1050 and Mouse.y > 510)
		$gtk.hide_cursor
	else
		$gtk.show_cursor
	end

end