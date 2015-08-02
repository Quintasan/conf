# Editor
Pry.editor = "nvim"

# Use one history file with Irb
Pry.config.history.file = "~/.irb_history"

# Bindings for pry-byebug
Pry.commands.alias_command 'c', 'continue' rescue nil
Pry.commands.alias_command 's', 'step' rescue nil
Pry.commands.alias_command 'n', 'next' rescue nil
Pry.commands.alias_command 'r!', 'reload!' rescue nil

# Colors!
Pry.config.color = true

# Custom prompt displaying Ruby version
Pry.prompt = [proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]
