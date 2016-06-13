require 'solr_wrapper'
require 'fcrepo_wrapper'
task ci: ['engine_cart:generate'] do
  # TODO: set port to nil (random port)
  solr_params = { port: '8985', verbose: true, managed: true }
  fcrepo_params = { port: '8986', verbose: true, managed: true }
  SolrWrapper.wrap(solr_params) do |solr|
    ENV['SOLR_TEST_PORT'] = solr.port
    solr.with_collection(name: 'hydra-test', dir: File.join(File.expand_path('.', File.dirname(__FILE__)), '..', 'solr', 'config')) do
      FcrepoWrapper.wrap(fcrepo_params) do |fcrepo|
        ENV['FCREPO_TEST_PORT'] = fcrepo.port
        Rake::Task['spec'].invoke
      end
    end
  end
end


namespace :book_concerns do
  task test_servers: ['engine_cart:generate'] do
    solr_params = { port: '8985', verbose: true, managed: true }
    fcrepo_params = { port: '8986', verbose: true, managed: true }
    SolrWrapper.wrap(solr_params) do |solr|
      ENV['SOLR_TEST_PORT'] = solr.port
      solr.with_collection(name: 'hydra-test', dir: File.join(File.expand_path('.', File.dirname(__FILE__)), '..', 'solr', 'config')) do
        FcrepoWrapper.wrap(fcrepo_params) do |fcrepo|
          ENV['FCREPO_TEST_PORT'] = fcrepo.port
          while true do
          end
        end
      end
    end
  end
end
