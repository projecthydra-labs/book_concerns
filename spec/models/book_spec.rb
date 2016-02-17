require 'spec_helper'

RSpec.describe Book do
  it "can initialize" do
    expect { described_class.new }.not_to raise_error
  end

  describe "#top_ranges" do
    subject { described_class.new.tap { |x| x.apply_depositor_metadata("bob") } }
    it "can be appended to" do
      top_range = TopRange.create
      subject.top_ranges << top_range

      expect(subject.top_ranges.first).to eq top_range
      subject.save!
      expect(subject.reload.top_ranges.first).to eq top_range
    end
  end
end
