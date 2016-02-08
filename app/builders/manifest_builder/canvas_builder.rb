class ManifestBuilder
  class CanvasBuilder
    attr_reader :record, :parent

    def initialize(record, parent)
      @record = record
      @parent = parent
      apply_record_properties
    end

    def canvas
      @canvas ||= IIIF::Presentation::Canvas.new
    end

    def path
      "#{parent.manifest_url}/canvas/#{record.id}"
    end

    def apply(sequence)
      sequence.canvases += [canvas]
    end

    private

    def apply_record_properties
      canvas['@id'] = path
      canvas.label = record.to_s
      # canvas.viewing_hint = record.viewing_hint if record.viewing_hint
      # attach_image
    end

    def attach_image
      iiif_path = IIIFPath.new(record.id)
      image = IIIF::Presentation::ImageResource.create_image_api_image_resource(
        service_id: iiif_path.to_s,
        format: 'image/jpeg'
      )
      annotation = IIIF::Presentation::Annotation.new
      annotation.resource = image
      annotation["on"] = path
      annotation["@id"] = parent_path.to_s + "/annotation/#{record.id}-image"
      canvas.images << annotation
      canvas.width = image.width
      canvas.height = image.height
    end
  end
end
