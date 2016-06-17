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

  describe "#update" do
    it "can update the viewing direction and viewing hint" do
      book = FactoryGirl.create(:book, user: user)

      response = patch :update, id: book.id, book: {
        viewing_direction: "left-to-right",
        viewing_hint: "continuous"
      }

      expect(response).to be_redirect
      book.reload
      expect(book.viewing_direction).to eq ["left-to-right"]
      expect(book.viewing_hint).to eq ["continuous"]
    end
  end

  describe "#show_presenter" do
    it "is the books presenter" do
      expect(described_class.show_presenter).to eq ::BookConcerns::Presenters::BookPresenter
    end
  end
end
