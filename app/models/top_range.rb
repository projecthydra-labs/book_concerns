class TopRange < ActiveFedora::Base
  # Can't be PCDM::Object, because it needs to
  #   persist member nodes as Hash URIs.
  type ::RDF::URI("http://pcdm.org/works#TopRange")

  property :label, predicate: ::RDF::RDFS.label do |index|
    index.as :stored_searchable, :symbol
  end
  property :nodes, predicate: ::RDF::Vocab::DC.hasPart
  property :head, predicate: ::RDF::Vocab::IANA['first'], multiple: false
  property :tail, predicate: ::RDF::Vocab::IANA.last, multiple: false
  property :members, predicate: ::Hydra::PCDM::Vocab::PCDMTerms.hasMember

  def membership=(membership)
    new_graph = RangeHash.new(membership, uri: rdf_subject, parent_uri: rdf_subject).to_graph
    resource << new_graph
    self.nodes = new_graph.subjects.to_a - [rdf_subject] - [::RDF::URI.new]
    nodes_will_change!
    head_will_change!
    tail_will_change!
    members_will_change!
  end

  def top_range?
    true
  end

  def pcdm_object?
    true
  end

  # Not useful and slows down indexing.
  def create_date
    nil
  end

  # Not useful, slows down indexing.
  def modified_date
    nil
  end

  # Serializing head/tail/nodes slows things down CONSIDERABLY, and is not
  # useful.
  # @note This method is used by ActiveFedora::Base upstream for indexing,
  #   at https://github.com/projecthydra/active_fedora/blob/master/lib/active_fedora/profile_indexing_service.rb.
  def serializable_hash(_options = nil)
    {}
  end
end
