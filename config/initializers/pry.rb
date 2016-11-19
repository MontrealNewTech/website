# requires awesome_print in Gemfile
Pry.config.requires = ['awesome_print']
Pry.config.print = proc { |output, value| output.puts value.ai }

# Show red environment name in pry prompt for non development environments
unless Rails.env.development?
  old_prompt = Pry.config.prompt
  env = Pry::Helpers::Text.red(Rails.env.upcase)
  Pry.config.prompt = old_prompt.map { |item| proc { |*a| "#{env} #{item.call(*a)}" } }
end
