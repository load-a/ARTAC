def tick args
	initial args if Kernel::tick_count == 0
	Update::variables args
	Update::classes args
	Update::objects args
	Update::outputs args


	sect_one = {
		w: 200,
		h: 90,
		primitive_marker: :solid
	}.merge(Color::orange)

	sect_two = {
		w: 250,
		h: 150,
		primitive_marker: :border
	}.merge(Color.blue)

	# text_one = ['Matsuo Basho is perhaps the most revered Haiku poet in Japanese literature.','The following poem--"An Old Pond"--is perhaps his most famous work:', '', 'Furu ike ya','kawazu tobikomu','mizu no oto', '']

	args.state.text_two ||= TextBlock.new("Here are some words for you to process. It is over 40 characters long!")
	args.state.text_one ||= TextBlock.new(['Here is. a second_line', 'I hope this ', 'works >.>'])

	args.state.win ||= Window.new( "TEST WINDOW", args.state.text_two, args.state.text_one)	

	args.state.x ||= 0
	args.state.x += 1
	args.state.y ||= 0
	args.state.y += 1

	args.state.win.move [args.state.x, args.state.y]

	Renderer.add args.state.win
	Renderer.render

	DebugTools::list([10, 700], [sect_two], args)


end
