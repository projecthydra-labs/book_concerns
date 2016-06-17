require 'spec_helper'

RSpec.describe BookConcerns::Presenters::BookPresenter do
  describe ".file_presenter_class" do
    it "is the locally scoped file presenter" do
      expect(described_class.file_presenter_class).to eq ::FileSetPresenter
    end
  end

  context "when it has a file set" do
    it "is able to generate a IIIF manifest" do
      presenter = described_class.new(SolrDocument.new(FactoryGirl.create(:book).to_solr), nil)
      file_set_presenter = FileSetPresenter.new(SolrDocument.new(FactoryGirl.create(:file_set).to_solr), nil)
      allow(presenter).to receive(:work_presenters).and_return([])
      allow(presenter).to receive(:member_presenters).and_return([file_set_presenter])

      manifest = JSON.parse(IIIFManifest::ManifestFactory.new(presenter).to_h.to_json)
      expect(manifest["sequences"][0]["canvases"].length).to eq 1
    end
  end

  context "when it has sub-books" do
    it "returns them as BookPresenters" do
      sub_book = FactoryGirl.create(:book)
      book = FactoryGirl.create(:book, ordered_members: [sub_book])
      presenter = described_class.new(SolrDocument.new(book.to_solr), nil)

      expect(presenter.work_presenters.first.class).to eq described_class
    end
  end
end
