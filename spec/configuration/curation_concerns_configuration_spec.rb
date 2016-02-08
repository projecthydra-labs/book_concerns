require 'spec_helper'

RSpec.describe CurationConcerns do
  it "adds Book as a curation concern" do
    expect(described_class.config.curation_concerns).to include Book
  end
end
