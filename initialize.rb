def initial args
	args.state.color_table_scene = [
		Window.new( [10, 100], "COLOR TABLE", ColorTable.new([0,0]) ),
		Window.new( [800, 100],"SPRITESHEET", [SPRITESHEET, TextBlock.new([''])] ),
		Window.new( [300, 100], "Buttons", [
				TextBlock.new(['1. asdf', '2. jkl;', '3. Profit']), 
				TextBlock.new("asdfa;lineioiee aeiknie anken")
			]),
		Window.new( [400, 400], "TEST", [TextBlock.new("Hello, world!")])
	]

	puts 'End of #initial method.'
end

