class Book < ActiveFedora::Base
  include ::CurationConcerns::WorkBehavior
  include ::CurationConcerns::BasicMetadata
  filters_association :related_objects, as: :top_ranges, condition: :top_range?
end
