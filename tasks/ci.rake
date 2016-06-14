require 'solr_wrapper'
require 'fcrepo_wrapper'
require 'active_fedora/rake_support'
task ci: ['engine_cart:generate'] do
  with_server('test') do
    Rake::Task['spec'].invoke
  end
end


namespace :book_concerns do
  desc "Run development servers for Book Concerns"
  task :dev_servers do
    with_server('development') do
      begin
        sleep
      rescue Interrupt
        puts "Stopping server"
      end
    end
  end
  desc "Run test servers for Book Concerns"
  task :test_servers do
    with_server('test') do
      begin
        sleep
      rescue Interrupt
        puts "Stopping server"
      end
    end
  end
end
