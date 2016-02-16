require 'spec_helper'

RSpec.describe ManifestBuilder::CanvasBuilder do
  subject { described_class.new(file_set, parent) }
  let(:file_set) { double("FileSet") }
  let(:parent) { instance_double(BookShowPresenter) }

  describe "#apply" do
    let(:sequence) { IIIF::Presentation::Sequence.new }
    before do
      allow(parent).to receive(:manifest_url).and_return("http://test.com/1")
      allow(file_set).to receive(:id).and_return("fileset")
    end
    it "applies a canvas to the sequence" do
      subject.apply(sequence)

      expect(sequence.canvases.length).to eq 1
    end
    it "builds an ID" do
      subject.apply(sequence)

      expect(sequence.canvases.first['@id']).to eq "http://test.com/1/canvas/fileset"
    end
    it "sets a label" do
      subject.apply(sequence)

      expect(sequence.canvases.first['label']).to eq file_set.to_s
    end

    context "when the file_set responds to #display_image" do
      let(:display_image) { instance_double(DisplayImage) }
      before do
        allow(file_set).to receive(:display_image).and_return(display_image)
        allow(display_image).to receive(:url).and_return("https://my_image.jpg")
        allow(display_image).to receive(:height).and_return(5000)
        allow(display_image).to receive(:width).and_return(3000)
        allow(display_image).to receive(:format).and_return("image/jpeg")
      end
      it "annotates that image on the canvas" do
        subject.apply(sequence)

        first_canvas = sequence.canvases.first
        expect(first_canvas.images.length).to eq 1
        first_image = first_canvas.images.first

        expect(first_image['motivation']).to eq "sc:painting"
        expect(first_image['on']).to eq first_canvas['@id']
        resource = first_image['resource']

        expect(resource['@id']).to eq display_image.url
        expect(resource['height']).to eq 5000
        expect(resource['width']).to eq 3000
        # Should this happen? Seems like it may end up problematic.
        expect(first_canvas['height']).to eq 5000
        expect(first_canvas['width']).to eq 3000
        expect(resource['format']).to eq "image/jpeg"

        # No service without a iiif url
        expect(resource['service']).to eq nil
      end
      context "when it has a IIIF url" do
        let(:iiif_endpoint) { instance_double(IIIFEndpoint) }
        before do
          allow(display_image).to receive(:iiif_endpoint).and_return(iiif_endpoint)
          allow(iiif_endpoint).to receive(:url).and_return("http://iiif.com/image.jpg")
          allow(iiif_endpoint).to receive(:profile).and_return("http://iiif.io/api/image/2/level2.json")
          allow(iiif_endpoint).to receive(:context).and_return("iiif_context")
        end
        it "builds a IIIF service" do
          subject.apply(sequence)

          first_resource = sequence.canvases.first.images.first.resource
          expect(first_resource['service']).not_to be_nil
          service = first_resource.service

          expect(service['@context']).to eq 'iiif_context'
          expect(service['@id']).to eq iiif_endpoint.url
          expect(service['profile']).to eq iiif_endpoint.profile
        end
      end
    end
  end
end
