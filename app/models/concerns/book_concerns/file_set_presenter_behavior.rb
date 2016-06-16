module BookConcerns
  module FileSetPresenterBehavior
    delegate :viewing_direction, to: :solr_document

    def viewing_hint
      solr_document.viewing_hint.first
    end
  end
end
