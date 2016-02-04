require 'rails/generators'

module BookConcerns
  class Install < Rails::Generators::Base
    def register_work
      inject_into_file 'config/initializers/curation_concerns.rb', after: "CurationConcerns.configure do |config|\n" do
        "  # Injected via `rails g book_concerns:install`\n" \
          "  config.register_curation_concern :book\n"
      end
    end
  end
end
