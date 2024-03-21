def tick args
	initial args if Kernel::tick_count == 0
	Update::variables args
	Update::classes args
	Update::objects args
	Update::outputs args

	args.state.scene ||= Scene.new("DEV", args.state.color_table_scene)
	unless Keyboard.letter.select {|key| key == :shift or key == :v}.empty?
		args.state.scene.make_everything_visible
	end





	texts = [
		Mouse.location,
		Mouse.on?(SPRITESHEET),
		SPRITESHEET.target_cell
	]

	if Mouse.on?(SPRITESHEET)
		SPRITESHEET.update_highlights(Mouse.location)
	end

	# Get the Mouse to identify colors on the color table
	# Mouse.sees_in(args.state.scene.extant.select{ |x| x.kind_of? Window}[0].primary_section.primitives).map{|e| e[:color_name]}


	DebugTools.list([10, 700], texts, args)

	Renderer.add args.state.scene
	Renderer.render
end
