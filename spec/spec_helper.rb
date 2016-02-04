require 'engine_cart'
require 'pry'
EngineCart.load_application!
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
require 'rspec/rails'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
