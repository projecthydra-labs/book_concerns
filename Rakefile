begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'engine_cart/rake_task'
# load rake tasks defined in lib/tasks that are not loaded in lib/active_fedora.rb
load "tasks/dev.rake"

Bundler::GemHelper.install_tasks
