require 'spec_helper'

RSpec.describe BookConcerns::Forms::FileSetEditForm do
  subject { described_class.new(file_set) }
  let(:file_set) { FactoryGirl.build(:file_set, viewing_hint: ["non-paged"]) }
  describe "#viewing_hint" do
    it "returns the first element" do
      expect(subject.viewing_hint).to eq "non-paged"
    end
  end
end
