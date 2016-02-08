begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
require 'engine_cart/rake_task'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
# load rake tasks defined in lib/tasks that are not loaded in lib/active_fedora.rb
Dir.glob('tasks/*.rake').each { |r| import r }

Bundler::GemHelper.install_tasks

task clean: 'engine_cart:clean'
task default: :ci
