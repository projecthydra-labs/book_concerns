class ManifestBuilder
  attr_reader :work
  def initialize(work)
    @work = work
  end

  def to_h
    @to_h ||= builders.apply(top_record)
  end

  private

    def manifest
      @manifest ||= manifest_builder_class
    end

    def builders
      CompositeBuilder.new(
        record_property_builder,
        sequence_builder
      )
    end

    def record_property_builder
      RecordPropertyBuilder.new(work)
    end

    def sequence_builder
      SequenceBuilder.new(work)
    end

    def top_record
      ::IIIF::Presentation::Manifest.new
    end
end
