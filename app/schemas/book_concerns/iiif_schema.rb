module BookConcerns
  class IIIFSchema < ActiveTriples::Schema
    property :viewing_direction, predicate: ::RDF::Vocab::IIIF.viewingDirection
    property :viewing_hint, predicate: ::RDF::Vocab::IIIF.viewingHint
  end
end
