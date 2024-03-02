require 'app/require_file_module.rb'

RequireFile::require_all_ruby_files

def tick args
	Mouse.update args
	Keyboard.update args

	scaffold_mode args

	args.outputs.labels << [50, 700, SCAFFOLD.info.to_s]
	args.outputs.borders << SCAFFOLD.rect.merge(Color.dark_blue)
end
