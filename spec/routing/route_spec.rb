require 'spec_helper'

describe 'Routes', type: :routing do
  describe 'Manifest Routes' do
    it 'routes to the manifest location' do
      expect(get: '/concern/books/1/manifest').to route_to(controller: 'curation_concerns/books', action: 'manifest', id: "1", format: :json)
    end
  end
end
