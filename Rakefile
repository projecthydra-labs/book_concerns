begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
require 'jettywrapper'

Jettywrapper.hydra_jetty_version = 'v8.7.0'

require 'engine_cart/rake_task'
# load rake tasks defined in lib/tasks that are not loaded in lib/active_fedora.rb
Dir.glob('tasks/*.rake').each { |r| import r }

Bundler::GemHelper.install_tasks
