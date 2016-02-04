require 'spec_helper'

RSpec.describe "CC Configuration" do
  it "adds Book as a curation concern" do
    expect(CurationConcerns.config.curation_concerns).to include Book
  end
end
