module BookConcerns
  module IndexesSchema
    extend ActiveSupport::Concern
    module ClassMethods
      def apply_schema_with_indexing(schema, *index_types)
        apply_schema schema, ActiveFedora::SchemaIndexingStrategy.new(
          ActiveFedora::Indexers::GlobalIndexer.new(index_types)
        )
      end
    end
  end
end
