require 'spec_helper'
require 'rspec/rails'

RSpec.describe CurationConcerns::BooksController, type: :controller do
  describe "#show" do
    it "works" do
      b = Book.create! { |c| c.apply_depositor_metadata("bob@test.com") }
      sign_in User.create(email: "bob@test.com", password: "password")
      expect(get :show, id: b.id).to be_success
    end
  end
end
