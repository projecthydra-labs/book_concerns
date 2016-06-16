module BookConcerns
  module Metadata
    extend ActiveSupport::Concern
    included do
      include ::BookConcerns::IndexesSchema
      apply_schema_with_indexing ::BookConcerns::IIIFSchema, :symbol
    end
  end
end
