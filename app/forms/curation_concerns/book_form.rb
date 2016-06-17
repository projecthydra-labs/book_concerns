# Generated via
#  `rails generate curation_concerns:work Book`
module CurationConcerns
  class BookForm < CurationConcerns::Forms::WorkForm
    self.model_class = ::Book
    self.terms += [:viewing_direction, :viewing_hint]

    def self.model_attributes(attrs)
      [:viewing_hint, :viewing_direction].each do |iiif_field|
        attrs[iiif_field] = Array(attrs[iiif_field]) if attrs[iiif_field]
      end
      super(attrs)
    end

    def viewing_hint
      self[:viewing_hint].first
    end

    def viewing_direction
      self[:viewing_direction].first
    end
  end
end
