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

	# I can't access a window directly because of the Renderer.
	# Investigate this.

	texts = [
		Mouse.location,
		SELECTOR.formatted_info,
		SPRITESHEET.target_cell,
		Mouse.sees_in(args.state.scene.windows).any? {|window| Mouse.on? window.exit_button_rect }
	]

	if !Mouse.sees_in(args.state.scene.windows).empty?
		if Mouse.click? and Mouse.on?(Mouse.sees_in(args.state.scene.windows)[0].exit_button_rect)
			args.state.scene.make_invisible Mouse.sees_in(args.state.scene.windows)[0]
		elsif Mouse.click?
			SELECTOR.take!(Mouse.sees_in(args.state.scene.windows)[0]) 
			SELECTOR.remember!(Geometry::coordinate_difference(Mouse.location, SELECTOR.possession.location))
		elsif Mouse.held?
			SELECTOR.possession.move(Geometry::coordinate_difference(Mouse.location, SELECTOR.memory))
		elsif Mouse.up?
			SELECTOR.forget!
			SELECTOR.drop!
		end
	end

	if Mouse.on?(SPRITESHEET)
		SPRITESHEET.update_highlights(Mouse.location)
	end

	# Get the Mouse to identify colors on the color table
	# Mouse.sees_in(args.state.scene.extant.select{ |x| x.kind_of? Window}[0].primary_section.primitives).map{|e| e[:color_name]}


	DebugTools.list([10, 700], texts, args)

	Renderer.add args.state.scene
	Renderer.render
end
