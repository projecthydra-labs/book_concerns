$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "book_concerns/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "book_concerns"
  s.version     = BookConcerns::VERSION
  s.authors     = ["Trey Terrell"]
  s.email       = ["tterrell@princeton.edu"]
  s.homepage    = "https://github.com/projecthydra-labs/book_concerns"
  s.summary     = "Curation Concern engine for Books."
  s.description = "Adds ingest, metadata, and derivative generation for books."
  s.license     = "APACHE2"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency "curation_concerns", '>= 1.0.0.beta9'
  s.add_dependency 'sprockets-es6'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "engine_cart"
  s.add_development_dependency "solr_wrapper", '~> 0.4'
  s.add_development_dependency "fcrepo_wrapper", '~> 0.1'
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "database_cleaner", "< 1.1.0"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency "capybara"
  s.add_development_dependency 'jasmine'
end
