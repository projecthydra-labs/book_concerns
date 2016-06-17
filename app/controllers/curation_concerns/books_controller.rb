# Generated via
#  `rails generate curation_concerns:work Book`

class CurationConcerns::BooksController < ApplicationController
  include CurationConcerns::CurationConcernController
  self.curation_concern_type = Book
  self.show_presenter = ::BookConcerns::Presenters::BookPresenter
  skip_load_and_authorize_resource only: :manifest

  def manifest
    respond_to do |f|
      f.json do
        render json: IIIFManifest::ManifestFactory.new(presenter).to_h
      end
    end
  end
end
