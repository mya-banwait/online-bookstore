# This is the Rakefile, which is like a Makefile for Ruby programs

require 'rubocop/rake_task'

# This line is what allows us to just enter "rake" in the command line and have the program run
task default: %[run]

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end

# Running "rake" is the same as entering "ruby [filename]" in the command line
# This runs the bookstore.rb file
task :run do
  ruby 'lib/bookstore.rb'
end

task :test do
  ruby 'test/cool_program_test.rb'
end
