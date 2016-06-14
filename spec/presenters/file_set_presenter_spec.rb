require 'spec_helper'

RSpec.describe FileSetPresenter do
  subject { FileSetPresenter.new(solr_doc, ability) }
  let(:ability) { nil }
  let(:solr_doc) do
    SolrDocument.new(
      id: "test",
      viewing_hint_ssim: ["paged"],
      viewing_direction_ssim: ["left-to-right"]
    )
  end

  describe "#viewing_hint" do
    it "delegates down" do
      expect(subject.viewing_hint).to eq "paged"
    end
  end

  describe "#viewing_direction" do
    it "delegates down" do
      expect(subject.viewing_direction).to eq ["left-to-right"]
    end
  end
end
