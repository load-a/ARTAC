def initial args
	Renderer.add SCAFFOLD
	Button.all.each { |button| Renderer.add button}

	args.state.window ||= Window.new('俳句', ['Matsuo Basho is perhaps the most revered Haiku poet in Japanese literature.','The following poem--"An Old Pond"--is perhaps his most famous work:', '', 'Furu ike ya','kawazu tobikomu','mizu no oto', ''], 0)
	Renderer.add args.state.window
	puts 'game properly initialized'
end

