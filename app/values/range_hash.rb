class RangeHash
  attr_reader :range_hash, :parent_uri
  def initialize(range_hash, uri: nil, parent_uri: ::RDF::URI.new)
    @range_hash = range_hash
    @parent_uri = parent_uri
    @uri = uri
  end

  def to_graph
    r = RDF::Graph.new
    r << to_node
    ordered_list = ActiveFedora::Orders::OrderedList.new(::RDF::Graph.new, nil, nil)
    members.each do |member|
      r << [uri, ::Hydra::PCDM::Vocab::PCDMTerms.hasMember, member.uri]
      r << member.to_graph
      ordered_list.insert_proxy_for_at(ordered_list.length, member.uri, proxy_in: self)
    end
    if members.length > 0
      r << [uri, ::RDF::Vocab::IANA.first, ordered_list.first.rdf_subject]
      r << [uri, ::RDF::Vocab::IANA.last, ordered_list.last.rdf_subject]
    end
    r << ordered_list.to_graph
    r
  end

  def members
    @members ||= Array.wrap(range_hash["members"]).map do |member|
      self.class.new(member, parent_uri: uri)
    end
  end

  def uri
    @uri ||=
      begin
        if id.blank?
          generate_node_uri
        else
          ::RDF::URI(ActiveFedora::Base.id_to_uri(id))
        end
      end
  end

  def id
    @id ||= range_hash["@id"]
  end

  def label
    range_hash["label"]
  end

  private

    def generate_node_uri
      ::RDF::URI.new("#{id}##{::RDF::Node.new.id}")
    end

    def to_node
      r = Resource.new(uri)
      r.label = Array.wrap(label)
      r
    end

    class Resource < ActiveTriples::Resource
      property :label, predicate: ::RDF::RDFS.label
    end

    class Proxy < ActiveTriples::Resource
      property :proxy_in, predicate: ::RDF::Vocab::ORE.proxyIn
      property :proxy_for, predicate: ::RDF::Vocab::ORE.proxyFor
      property :prev, predicate: ::RDF::Vocab::IANA.prev
      property :next, predicate: ::RDF::Vocab::ORE.proxyFor
    end
end
