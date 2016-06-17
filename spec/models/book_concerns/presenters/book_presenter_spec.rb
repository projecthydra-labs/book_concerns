require 'spec_helper'

RSpec.describe BookConcerns::Presenters::BookPresenter do
  subject { described_class.new(solr_document, nil) }
  let(:solr_document) { SolrDocument.new(book.to_solr) }
  let(:book) { FactoryGirl.build(:book, viewing_direction: ["left-to-right"], viewing_hint: ["individuals"]) }
  describe "#viewing_direction" do
    it "returns the first viewing direction" do
      expect(subject.viewing_direction).to eq "left-to-right"
    end
  end
  describe "#viewing_hint" do
    it "returns the first viewing hint" do
      expect(subject.viewing_hint).to eq "individuals"
    end
  end
end
