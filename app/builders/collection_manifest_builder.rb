class CollectionManifestBuilder < ManifestBuilder
  def work
    decorated_work
  end

  private

    def builders
      ::ManifestBuilder::CompositeBuilder.new(
        record_property_builder,
        child_manifest_builder
      )
    end

    def child_manifest_builder
      ::ManifestBuilder::CompositeBuilder.new(
        *work.work_presenters.map do |work_presenter|
          ChildManifestBuilder.new(work_presenter)
        end
      )
    end

    def top_record
      ::IIIF::Presentation::Collection.new
    end

    def decorated_work
      @decorated_work ||=
        begin
          IIIFCollection.new(@work)
        end
    end
end
