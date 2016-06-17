require 'spec_helper'

RSpec.describe Book do
  it "can initialize" do
    expect { described_class.new }.not_to raise_error
  end
  describe "iiif fields" do
    describe "#viewing_direction" do
      it "indexes it" do
        subject.viewing_direction = ["left-to-right"]
        expect(subject.to_solr.keys).to include "viewing_direction_ssim"
      end

      describe "#viewing_hint" do
        it "indexes it" do
          subject.viewing_hint = ["paged"]
          expect(subject.to_solr.keys).to include "viewing_hint_ssim"
        end
      end
    end
  end
end
