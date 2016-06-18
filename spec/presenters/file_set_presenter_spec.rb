require 'spec_helper'

RSpec.describe FileSetPresenter do
  subject { described_class.new(solr_doc, ability) }
  let(:ability) { nil }
  let(:solr_doc) do
    SolrDocument.new(
      id: "test",
      viewing_hint_ssim: ["paged"],
      viewing_direction_ssim: ["left-to-right"],
      height_is: 200,
      width_is: 300,
      mime_type_ssi: "image/png"
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

  describe "#height" do
    it "returns the height" do
      expect(subject.height).to eq 200
    end
  end

  describe "#width" do
    it "returns the width" do
      expect(subject.width).to eq 300
    end
  end

  describe "#mime_type" do
    it "returns the mime type" do
      expect(subject.mime_type).to eq "image/png"
    end
  end
end
