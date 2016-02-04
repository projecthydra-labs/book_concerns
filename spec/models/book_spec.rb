require 'spec_helper'

RSpec.describe Book do
  it "can initialize" do
    expect{ described_class.new }.not_to raise_error
  end
end
