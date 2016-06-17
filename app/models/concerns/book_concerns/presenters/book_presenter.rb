module BookConcerns
  module Presenters
    class BookPresenter < CurationConcerns::WorkShowPresenter
      include Rails.application.routes.url_helpers
      include ActionDispatch::Routing::PolymorphicRoutes

      self.file_presenter_class = ::FileSetPresenter
      self.work_presenter_class = ::BookConcerns::Presenters::BookPresenter

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

      def manifest_url
        polymorphic_url([:manifest, self])
      end
    end
  end
end
