require 'spec_helper'

RSpec.describe TopRange do
  subject { described_class.new }

  describe "#type" do
    it "sets a top range type" do
      expect(subject.type).to include "http://pcdm.org/works#TopRange"
    end
  end

  describe "#label" do
    it "can be set" do
      subject.label = ["Test"]
      expect(subject.label).to eq ["Test"]
    end
  end

  describe "#membership=" do
    let(:membership) do
      {
        "members" => [
          {
            "@id" => resource.id
          }
        ]
      }
    end
    let(:resource) { Book.create! { |x| x.apply_depositor_metadata("test") } }
    it "sets an order and asserts hash URIs" do
      initial_length = subject.resource.statements.to_a.length
      subject.membership = membership

      member_count = 1
      expect(subject.resource.statements.to_a.length).to eq initial_length + member_count * 5 + member_count
    end
    context "when setting nested members" do
      let(:membership) do
        {
          "members" => [
            {
              "label" => "Chapter 1",
              "members" => [
                {
                  "@id" => resource.id
                }
              ]
            }
          ]
        }
      end
      it "works" do
        initial_length = subject.resource.statements.to_a.length
        subject.membership = membership

        expect(subject.resource.statements.to_a.length).to eq initial_length + 14
      end
      it "survive persistence" do
        subject.save
        initial_length = subject.resource.statements.to_a.length
        subject.membership = membership
        subject.save

        expect(subject.resource.statements.to_a.length).to eq initial_length + 14
      end
    end
    it "survives persistence" do
      subject.save
      initial_length = subject.resource.statements.to_a.length

      subject.membership = membership

      subject.save

      member_count = 1
      expect(subject.resource.statements.to_a.length).to eq initial_length + member_count * 5 + member_count
    end
  end
end
