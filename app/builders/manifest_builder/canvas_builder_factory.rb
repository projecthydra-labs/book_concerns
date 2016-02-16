class ManifestBuilder
  class CanvasBuilderFactory
    attr_reader :composite_builder, :canvas_builder_factory
    def initialize(composite_builder:, canvas_builder_factory:)
      @composite_builder = composite_builder
      @canvas_builder_factory = canvas_builder_factory
    end

    def from(work)
      composite_builder.new(
        *work.file_set_presenters.map do |presenter|
          canvas_builder_factory.new(presenter, work)
        end
      )
    end
  end
end
