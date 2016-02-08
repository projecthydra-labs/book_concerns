require 'spec_helper'

RSpec.describe ManifestBuilder::CanvasBuilder do
  subject { described_class.new(file_set, parent) }
  let(:file_set) { instance_double(FileSet) }
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
  end
end
