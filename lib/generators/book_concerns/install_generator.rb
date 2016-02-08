require 'rails/generators'

module BookConcerns
  class Install < Rails::Generators::Base
    def register_work
      inject_into_file 'config/initializers/curation_concerns.rb', after: "CurationConcerns.configure do |config|\n" do
        "  # Injected via `rails g book_concerns:install`\n" \
          "  config.register_curation_concern :book\n"
      end
    end

    def install_routes
      inject_into_file 'config/routes.rb', after: /curation_concerns_embargo_management\s*\n/ do
        "  mount BookConcerns::Engine => '/'\n"\
      end
    end

    def default_url
      inject_into_file 'config/application.rb', after: /raise_in_transactional_callbacks.*\n/ do
        "    config.action_mailer.default_url_options = { host: \"test.com\" }\n"\
      end
    end
  end
end
