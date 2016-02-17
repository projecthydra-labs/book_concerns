require 'spec_helper'

RSpec.describe ManifestFactory do
  subject { described_class.new(book_presenter) }
  let(:book_presenter) do
    BookShowPresenter.new(SolrDocument.new(book.to_solr), nil)
  end
  let(:book) do
    Book.new("test")
  end
  describe "#to_h" do
    let(:result) { subject.to_h }
    let(:json_result) { JSON.parse(subject.to_h.to_json) }
    it "has a label" do
      expect(result.label).to eq book_presenter.to_s
    end
    it "has an ID" do
      expect(result['@id']).to eq "http://test.com/concern/books/test/manifest"
    end
    context "when there are no files" do
      it "returns no sequences" do
        expect(result["sequences"]).to eq nil
      end
    end
    context "when there is a fileset" do
      let(:file_presenter) { CurationConcerns::FileSetPresenter.new(SolrDocument.new(file_set.to_solr), nil) }
      let(:file_set) { FileSet.new("fileset1") }
      it "returns a sequence" do
        allow(ManifestBuilder::CanvasBuilder).to receive(:new).and_call_original
        allow(book_presenter).to receive(:file_presenters).and_return([file_presenter])

        result

        expect(ManifestBuilder::CanvasBuilder).to have_received(:new).exactly(1).times.with(file_presenter, anything)
      end
    end
    context "when there are child works" do
      let(:child_work_presenter) { BookShowPresenter.new(SolrDocument.new(book2.to_solr), nil) }
      let(:book2) do
        Book.new("test2")
      end
      before do
        allow(book_presenter).to receive(:file_presenters).and_return([child_work_presenter])
      end
      it "returns a IIIF Collection" do
        expect(result['@type']).to eq "sc:Collection"
      end
      it "doesn't build sequences" do
        expect(result['sequences']).to eq nil
      end
      it "has a multi-part viewing hint" do
        expect(json_result["viewingHint"]).to eq "multi-part"
      end
      it "builds child manifests" do
        expect(result["manifests"].length).to eq 1
        first_child = result["manifests"].first
        expect(first_child['@id']).to eq "http://test.com/concern/books/test2/manifest"
        expect(first_child['@type']).to eq "sc:Manifest"
        expect(first_child['label']).to eq child_work_presenter.to_s
      end
    end
    context "when there are child works AND files" do
      class DisplayImagePresenter < CurationConcerns::FileSetPresenter
        def display_image
          DisplayImage.new(id, width: 100, height: 100, format: "image/jpeg")
        end
      end
      let(:child_work_presenter) { BookShowPresenter.new(SolrDocument.new(book2.to_solr), nil) }
      let(:book2) do
        Book.new("test2")
      end
      let(:file_presenter) { DisplayImagePresenter.new(SolrDocument.new(file_set.to_solr), nil) }
      let(:file_set) { FileSet.new("fileset1") }
      let(:file_presenter2) { DisplayImagePresenter.new(SolrDocument.new(file_set2.to_solr), nil) }
      let(:file_set2) { FileSet.new("fileset2") }
      before do
        allow(book_presenter).to receive(:file_presenters).and_return([child_work_presenter, file_presenter])
        allow(child_work_presenter).to receive(:file_presenters).and_return([file_presenter2])
      end
      it "returns a IIIF Manifest" do
        expect(result['@type']).to eq "sc:Manifest"
      end
      it "doesn't build manifests" do
        expect(result['manifests']).to eq nil
      end
      it "builds sequences from all the child file sets" do
        expect(result["sequences"].first["canvases"].length).to eq 2
      end
    end
  end
end
