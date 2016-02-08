require 'spec_helper'

RSpec.describe ManifestBuilder do
  subject { described_class.new(book_presenter) }
  let(:book_presenter) do
    BookShowPresenter.new(SolrDocument.new(book.to_solr), nil)
  end
  let(:book) do
    Book.new("test")
  end
  describe "#to_h" do
    let(:result) { subject.to_h }
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
        allow(book_presenter).to receive(:file_presenters).and_return([file_presenter])

        expect(result["sequences"].length).to eq 1
      end
    end
  end
end
