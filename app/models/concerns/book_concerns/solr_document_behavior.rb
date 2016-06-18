module BookConcerns
  module SolrDocumentBehavior
    def viewing_hint
      fetch(Solrizer.solr_name('viewing_hint', :symbol), [])
    end

    def viewing_direction
      fetch(Solrizer.solr_name('viewing_direction', :symbol), [])
    end

    def height
      fetch("height_is", 0)
    end

    def width
      fetch("width_is", 0)
    end
  end
end
