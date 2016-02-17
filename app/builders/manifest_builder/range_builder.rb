class ManifestBuilder::RangeBuilder
  attr_reader :order_json, :parent
  def initialize(order_json, parent)
    @order_json = order_json
    @parent = parent
    apply_properties
    build_canvases
    build_ranges
  end

  def to_h
    range
  end

  def apply(manifest)
    ([self] + ranges).each do |range|
      manifest.structures << range.to_h
    end
    manifest
  end

  def id
    "#{parent.manifest_url}/range/#{order.id}"
  end

  def ranges
    @ranges ||= order.ranges.map do |range|
      self.class.new(range.to_h, parent)
    end
  end

  private

    def apply_properties
      range['@id'] = id
      range.viewing_hint = order.viewing_hint if order.viewing_hint
    end

    def build_canvases
      order.canvases.each do |canvas|
        range.canvases << ::ManifestBuilder::CanvasBuilder.new(canvas, parent).path
      end
    end

    def build_ranges
      ranges.each do |child_range|
        range.ranges << child_range.id
      end
    end

    def order
      @order ||= Order.new(order_json)
    end

    def range
      @range ||= IIIF::Presentation::Range.new
    end

    class Order
      attr_reader :order_json
      def initialize(order_json)
        @order_json = order_json
      end

      def id
        order_json["@id"].delete("#")
      end

      def label
        order_json["label"]
      end

      def ranges
        @ranges ||= members.select do |member|
          member.type.include?(range_uri)
        end
      end

      def members
        @members ||= Array.wrap(order_json["members"]).map do |member_node|
          Order.new(member_node)
        end
      end

      def canvases
        members.select do |member|
          !ranges.include?(member)
        end
      end

      def viewing_hint
        "Top" if type.include?(top_range_uri)
      end

      def to_h
        order_json
      end

      def type
        Array.wrap(order_json["@type"])
      end

      private

        def top_range_uri
          "http://pcdm.org/works#TopRange"
        end

        def range_uri
          "http://pcdm.org/works#Range"
        end
    end
end
