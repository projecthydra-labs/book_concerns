require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
)
SimpleCov.start 'rails' do
  add_filter '/.internal_test_app'
  add_filter '/lib/generators'
  add_filter '/lib/book_concerns'
  add_filter '/solr_conf'
  add_filter '/spec'
  add_filter '/vendor'
end
