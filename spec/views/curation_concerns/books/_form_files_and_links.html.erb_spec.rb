require 'spec_helper'

RSpec.describe "curation_concerns/books/_form_files_and_links", type: :view do
  it "is empty" do
    render

    expect(rendered).to eq ""
  end
end
