# Generated via
#  `rails generate curation_concerns:work Book`

class CurationConcerns::BooksController < ApplicationController
  include CurationConcerns::CurationConcernController
  self.curation_concern_type = Book
  self.show_presenter = ::BookConcerns::Presenters::BookPresenter
end
