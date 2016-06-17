require 'spec_helper'

RSpec.describe CurationConcerns::FileSetsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user
  end
  describe "#update" do
    it "is able to update the viewing hint" do
      file_set = FactoryGirl.create(:file_set, user: user)

      response = patch :update, id: file_set.id, file_set: { viewing_hint: "non-paged" }

      expect(response).to be_redirect
      expect(file_set.reload.viewing_hint).to eq ["non-paged"]
    end
  end
end
