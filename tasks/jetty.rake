import File.join(Gem::Specification.find_by_name('curation_concerns-models').gem_dir,
                     'lib/tasks/curation_concerns-models_tasks.rake')
namespace :jetty do
  desc "Copies the default Solr & Fedora configs into the bundled Hydra Testing Server"
  task :config do
    Rake::Task['hydra_works:jetty:config'].invoke
    Rake::Task["jetty:config_solr"].invoke
  end

  desc "Copies the contents of solr_conf into the Solr development-core and test-core of Testing Server"
  task :config_solr do
    FileList['solr_conf/conf/*'].each do |f|
      cp("#{f}", 'jetty/solr/development-core/conf/', verbose: true)
      cp("#{f}", 'jetty/solr/test-core/conf/', verbose: true)
    end
  end
end
