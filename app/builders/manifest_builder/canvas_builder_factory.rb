class ManifestBuilder
  class CanvasBuilderFactory
    class << self
      def from(work)
        ::ManifestBuilder::CompositeBuilder.new(
          *work.file_set_presenters.map do |presenter|
            ::ManifestBuilder::CanvasBuilder.new(presenter, work)
          end
        )
      end
    end
  end
end
