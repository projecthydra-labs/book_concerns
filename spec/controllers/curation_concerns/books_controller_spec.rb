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
end
