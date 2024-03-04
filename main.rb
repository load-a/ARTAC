require 'app/require_file_module.rb'

RequireFile::require_all_ruby_files

def tick args
	Mouse.update args
	Keyboard.update args

	args.state.commit ||= ClickButton.new([53, 10], [150, 50], "create lattice")	
	args.state.clear ||=  ClickButton.new([195, 300], [150, 50], 'clear lattice')

	args.state.clear.put_right_of!(args.state.commit)
	args.state.clear.align_vertically_with!(args.state.commit)

	Button.all.each { |button| button.resize_to_fit_text }

	scaffold_mode args

	# This is required for click buttons to function properly.
	if Mouse.button.kind_of? ClickButton and Mouse.button.true? and !Mouse.click?
		Mouse.button.release
	end

	if Mouse.on_button?
		Mouse.highlight_button
		SELECTOR.remember! Mouse.button if SELECTOR.blank?
		Mouse.interact_with_button		
	end

	if SELECTOR.memory.kind_of? Button and !Mouse.on_button?
		SELECTOR.memory.unhighlight
		SELECTOR.forget!
	end

	if args.state.commit.true? and Level.every(Lattice).empty?
		Lattice.new(SCAFFOLD.location, SCAFFOLD.size.map {|e| e/SCAFFOLD.cell_size}, SCAFFOLD.cell_size)
	end

	if args.state.clear.true?
		SCAFFOLD.clear!
		Level.delete_every!(Lattice)
	end

	Mouse.highlight_lattice
	

	args.outputs.borders << SCAFFOLD.rect.merge(Color.dark_blue)
	texts = [ Mouse.formatted_info, SCAFFOLD.formatted_info, Level.formatted_info, Button.info, args.state.count ]
	DebugTools.list([50, 700], texts, args)
	DebugTools.quick_render_primitives(Level.all_primitives, args)
	DebugTools.quick_render_primitives(Button.all, args)
end
