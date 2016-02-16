require 'spec_helper'
require 'rspec/rails'

RSpec.describe CurationConcerns::BooksController, type: :controller do
  let(:user) { User.create!(email: "bob@test.com", password: "password") }
  before do
    sign_in user if user
  end
  describe "#show" do
    it "works" do
      b = Book.create! { |c| c.apply_depositor_metadata("bob@test.com") }

      expect(get(:show, id: b.id)).to be_success
    end
  end

  describe "#manifest" do
    routes { BookConcerns::Engine.routes }
    it "generates a manifest for the record" do
      b = Book.new { |c| c.apply_depositor_metadata(user.email) }
      f = FileSet.create { |s| s.apply_depositor_metadata(user.email) }
      f2 = FileSet.create { |s| s.apply_depositor_metadata(user.email) }
      b.ordered_members << f
      b.ordered_members << f2
      b.save!

      get :manifest, id: b.id, format: :json
      expect(response).to be_success
    end
  end
end
