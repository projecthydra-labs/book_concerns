begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
require 'engine_cart/rake_task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.requires << 'rubocop-rspec'
  task.fail_on_error = true
end
task spec: :rubocop do
  RSpec::Core::RakeTask.new(:spec)
end
# load rake tasks defined in lib/tasks that are not loaded in lib/active_fedora.rb
Dir.glob('tasks/*.rake').each { |r| import r }

Bundler::GemHelper.install_tasks

task clean: 'engine_cart:clean'
task default: :ci
