module BookConcerns
  module Presenters
    class BookPresenter < CurationConcerns::WorkShowPresenter
      self.file_presenter_class = ::FileSetPresenter
    end
  end
end
