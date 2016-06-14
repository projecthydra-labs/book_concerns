module BookConcerns
  module Presenters
    class BookPresenter < CurationConcerns::WorkShowPresenter
      self.file_presenter_class = ::FileSetPresenter

      def viewing_direction
        solr_document.viewing_direction.first
      end

      def viewing_hint
        solr_document.viewing_hint.first
      end

      def viewing_hints
        [
          'individuals',
          'paged',
          'continuous'
        ]
      end

      def viewing_directions
        [
          'left-to-right',
          'right-to-left',
          'top-to-bottom',
          'bottom-to-top'
        ]
      end
    end
  end
end
