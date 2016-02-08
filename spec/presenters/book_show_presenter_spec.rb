require 'spec_helper'

RSpec.describe BookShowPresenter do
  subject { described_class.new(book_solr_document, nil) }
  let(:book_solr_document) { SolrDocument.new(book.to_solr) }
  let(:book) { Book.new { |x| x.apply_depositor_metadata("test") } }

  describe "#file_set_presenters" do
    context "when it has file presenters which are file sets" do
      it "returns just the file sets" do
        file_set = FileSet.new { |x| x.apply_depositor_metadata("test") }
        sub_book = Book.new { |x| x.apply_depositor_metadata("test") }
        book.ordered_members << file_set
        book.ordered_members << sub_book
        book.save!

        expect(subject.file_set_presenters.length).to eq 1
        expect(subject.file_set_presenters.first.id).to eq file_set.id
      end
    end
  end
end
