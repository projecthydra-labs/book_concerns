require 'rails/generators'

module BookConcerns
  class Install < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    def register_work
      inject_into_file 'config/initializers/curation_concerns.rb', after: "CurationConcerns.configure do |config|\n" do
        "  # Injected via `rails g book_concerns:install`\n" \
          "  config.register_curation_concern :book\n"
      end
    end

    def inject_into_file_set
      file_path = 'app/models/file_set.rb'
      if File.exist?(file_path)
        inject_into_file file_path, after: /include ::CurationConcerns::FileSetBehavior.*$/ do
          "\n  # BookConcerns behavior to FileSet.\n" \
            "  include ::BookConcerns::FileSetBehavior\n"
        end
      else
        copy_file 'models/file_set.rb', file_path
      end
    end

    def create_file_presenter
      file_path = 'app/presenters/file_set_presenter.rb'
      if File.exist?(file_path)
        inject_into_file file_path, after: /class FileSetPresenter.*$/ do
          "\n  # BookConcerns FileSetPresenter behavior\n" \
            "  include ::BookConcerns::FileSetPresenterBehavior\n"
        end
      else
        copy_file 'presenters/file_set_presenter.rb', file_path
      end
    end

    # Add behaviors to the SolrDocument model
    def inject_solr_document_behavior
      file_path = 'app/models/solr_document.rb'
      if File.exist?(file_path)
        inject_into_file file_path, after: /include Blacklight::Solr::Document.*$/ do
          "\n  # Adds BookConcerns behaviors to the SolrDocument.\n" \
            "  include BookConcerns::SolrDocumentBehavior\n"
        end
      else
        Rails.logger.info "     \e[31mFailure\e[0m  BookConcerns requires a SolrDocument object. This generators assumes that the model is defined in the file #{file_path}, which does not exist."
      end
    end

    def install_assets
      copy_file 'book_concerns.js', 'app/assets/javascripts/book_concerns.js'
      copy_file 'book_concerns.scss', 'app/assets/stylesheets/book_concerns.scss'
    end

    def install_file_sets_controller
      file_path = 'app/controllers/curation_concerns/file_sets_controller.rb'
      copy_file 'controllers/curation_concerns/file_sets_controller.rb', file_path
    end
  end
end
