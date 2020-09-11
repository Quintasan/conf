begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError
end

# Editor
Pry.editor = ENV.fetch('EDITOR', 'vim')

# Use one history file with Irb
Pry.config.history_file = '~/.irb_history'

# Bindings for pry-byebug
begin
  Pry.commands.alias_command 'c', 'continue'
rescue StandardError
  nil
end
begin
  Pry.commands.alias_command 's', 'step'
rescue StandardError
  nil
end
begin
  Pry.commands.alias_command 'n', 'next'
rescue StandardError
  nil
end
begin
  Pry.commands.alias_command 'r!', 'reload!'
rescue StandardError
  nil
end

# Colors!
Pry.config.color = true

# Custom prompt displaying Ruby version
Pry.config.prompt = Pry::Prompt.new(
  'custom', 'my custom prompt with Ruby version',
  [
    proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " },
    proc { |obj, nest_level, _| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }
  ]
)
