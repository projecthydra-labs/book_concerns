require 'spec_helper'

RSpec.describe FileSet do
  subject { FileSet.new }
  describe "#viewing_hint" do
    it "indexes it" do
      subject.viewing_hint = ["left-to-right"]
      expect(subject.to_solr.keys).to include "viewing_hint_ssim"
    end
  end
end
