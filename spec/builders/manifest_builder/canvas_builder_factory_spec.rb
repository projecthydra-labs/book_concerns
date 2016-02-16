require 'spec_helper'

RSpec.describe ManifestBuilder::CanvasBuilderFactory do
  subject { ManifestServiceLocator.canvas_builder_factory }
  describe ".from" do
    let(:work) { instance_double(BookShowPresenter) }
    let(:result) { subject.from(work) }
    context "when a work has no file sets" do
      before do
        allow(work).to receive(:file_set_presenters).and_return([])
      end
      it "returns an empty composite builder" do
        expect(result.length).to eq 0
      end
    end
    context "when a work has file sets" do
      let(:file_set) { instance_double(CurationConcerns::FileSetPresenter) }
      before do
        allow(work).to receive(:file_set_presenters).and_return([file_set])
      end
      it "builds a canvas for each file set" do
        canvas_builder = instance_double(ManifestBuilder::CanvasBuilder)
        allow(ManifestBuilder::CanvasBuilder).to receive(:new).with(file_set, work).and_return(canvas_builder)

        expect(result.services).to eq [canvas_builder]
      end
    end
  end
end
