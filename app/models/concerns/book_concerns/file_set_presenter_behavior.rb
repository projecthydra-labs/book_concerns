module BookConcerns
  module FileSetPresenterBehavior
    delegate :viewing_direction, :height, :width, :mime_type, to: :solr_document

    def viewing_hint
      solr_document.viewing_hint.first
    end

    def display_image
      IIIFManifest::DisplayImage.new(id,
                                     width: width,
                                     height: height,
                                     format: mime_type)
    end
  end
end
