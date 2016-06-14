require 'spec_helper'

RSpec.describe "curation_concerns/books/file_manager.html.erb", type: :view do
  let(:book) { FactoryGirl.create(:book) }
  let(:presenter) { BookConcerns::Presenters::BookPresenter.new(solr_document, nil) }
  let(:solr_document) { SolrDocument.new(book.to_solr) }
  let(:members) do
    [file_set_presenter, child_book_presenter]
  end
  let(:file_set_presenter) do
    ::FileSetPresenter.new(SolrDocument.new(file_set.to_solr), nil)
  end
  let(:file_set) { FileSet.new.tap{|x| x.apply_depositor_metadata("test")}.tap{|x| x.save} }
  let(:child_book_presenter) do
    presenter.class.new(
      SolrDocument.new(FactoryGirl.create(:book).to_solr),
      nil
    )
  end
  before do
    view.lookup_context.prefixes << "curation_concerns/base"
    allow(presenter).to receive(:member_presenters).and_return(members)
    assign(:presenter, presenter)
    stub_blacklight_views
    render template: "curation_concerns/base/file_manager"
  end

  it "has a radio button for each file set's viewing hint" do
    expect(rendered).to have_selector("input[type=radio][name='file_set[viewing_hint]']", count: 3)
    ["Single Page", "Non-Paged", "Facing pages"].each do |hint|
      expect(rendered).to have_field hint
    end
  end
  context "when there's a viewing hint" do
    let(:book) { FactoryGirl.create(:book, viewing_hint: ["non-paged"]) }
    it "marks a button as selected" do
      expect(rendered).to have_selector("input[type=radio][name='file_set[viewing_hint]'][checked]")
    end
  end
end
