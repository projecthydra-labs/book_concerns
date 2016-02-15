class ChildManifestBuilder < ManifestBuilder
  def apply(manifest)
    manifest['manifests'] ||= []
    manifest['manifests'] << to_h
    manifest
  end

  private

    def builders
      ::ManifestBuilder::CompositeBuilder.new(
        record_property_builder
      )
    end
end
