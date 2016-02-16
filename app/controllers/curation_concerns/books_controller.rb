# Generated via
#  `rails generate curation_concerns:work Book`

class CurationConcerns::BooksController < ApplicationController
  include CurationConcerns::CurationConcernController
  set_curation_concern_type Book
  skip_load_and_authorize_resource only: :manifest

  def manifest
    respond_to do |format|
      format.json { render json: manifest_builder.to_h }
    end
  end

  private

    def manifest_builder
      ManifestFactory.new(presenter)
    end

    def show_presenter
      BookShowPresenter
    end
end
