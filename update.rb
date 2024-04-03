module Update
	extend self

	def classes args
		Mouse.update args
		Keyboard.update args
		Renderer.update args
	end

	def variables args

	end

	def objects args

	end

	def outputs args
		DebugTools.list([50, 700], args.state.texts, args)
		# Renderer.add args.state.scene
		Renderer.render
	end

end