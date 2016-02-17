require 'spec_helper'

RSpec.describe ManifestBuilder::RangeBuilder do
  subject { described_class.new(order_json, parent_work) }
  let(:order_json) { {} }
  let(:parent_work) { double("parent_work") }
  before do
    allow(parent_work).to receive(:manifest_url).and_return("http://test.com/1/manifest")
  end
  describe "#to_h" do
    context "when the JSON has only one node" do
      let(:order_json) do
        {
          "@type" => [
            "http://pcdm.org/works#TopRange"
          ],
          "@id" => "1",
          "members" => [
            {
              "@id" => "1234"
            }
          ]
        }
      end
      it "builds a single range under a top range" do
        top_range = JSON.parse(subject.to_h.to_json)

        expect(top_range["@id"]).to eq "http://test.com/1/manifest/range/1"
        expect(top_range["@type"]).to eq "sc:Range"
        expect(top_range["viewingHint"]).to eq "Top"
        expect(top_range["canvases"].length).to eq 1
      end
    end
    context "when the JSON has sub-ranges" do
      let(:order_json) do
        {
          "@type" => [
            "http://pcdm.org/works#TopRange"
          ],
          "@id" => "1",
          "members" => [
            {
              "@type" => [
                "http://pcdm.org/works#Range"
              ],
              "@id" => "#ba",
              "label" => "Chapter 1",
              "members" => [
                {
                  "@id" => "1234"
                }
              ]
            }
          ]
        }
      end
      it "builds a single range under a top range" do
        top_range = JSON.parse(subject.to_h.to_json)

        expect(top_range["@type"]).to eq "sc:Range"
        expect(top_range["viewingHint"]).to eq "Top"
        expect(top_range["ranges"].length).to eq 1

        first_range = JSON.parse(subject.ranges.first.to_h.to_json)
        expect(first_range['@type']).to eq "sc:Range"
        expect(first_range['viewingHint']).to be_nil
        expect(first_range["ranges"]).to be_nil
        expect(first_range["canvases"].length).to eq 1
      end

      it "can be applied to a manifest" do
        manifest = IIIF::Presentation::Manifest.new

        json = subject.apply(manifest).to_json(force: true)
        result = JSON.parse(json)
        expect(result["structures"].length).to eq 2
      end
    end
  end
end
