require 'fcrepo_wrapper'
require 'solr_wrapper'
desc "CI build"
task :ci do
  ENV['environment'] = "test"
  solr_params = { port: 8983, verbose: true, managed: true }
  fcrepo_params = { port: 8984, verbose: true, managed: true }
  SolrWrapper.wrap(solr_params) do |solr|
    solr.with_collection(name: 'hydra-test', dir: File.join(File.expand_path("../..", File.dirname(__FILE__)), "solr", "config")) do
      FcrepoWrapper.wrap(fcrepo_params) do
        Rake::Task['spec'].invoke
      end
    end
  end
end
