require 'spec_helper'

RSpec.describe CurationConcerns::BookForm do
  subject { described_class.new(book, nil) }
  let(:book) { FactoryGirl.build(:book, viewing_hint: ["individuals"], viewing_direction: ["left-to-right"]) }

  describe "#viewing_hint" do
    it "returns the first" do
      expect(subject.viewing_hint).to eq "individuals"
    end
  end

  describe "#viewing_direction" do
    it "returns thef irst" do
      expect(subject.viewing_direction).to eq "left-to-right"
    end
  end
end
