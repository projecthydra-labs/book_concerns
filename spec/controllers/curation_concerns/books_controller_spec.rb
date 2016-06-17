require 'spec_helper'
require 'rspec/rails'

RSpec.describe CurationConcerns::BooksController, type: :controller do
  let(:user) { User.create!(email: "bob@test.com", password: "password") }
  before do
    if user
      sign_in user
    else
      sign_out :user
    end
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

  describe "#manifest" do
    context "when they don't have access to the resource" do
      let(:user) { nil }
      it "returns unauthorized" do
        book = FactoryGirl.create(:book)

        get :manifest, id: book.id, format: :json

        expect(response).to be_unauthorized
      end
    end
    context "when the owner of the resource" do
      context "when given a book with a single page" do
        it "returns a valid manifest" do
          book = FactoryGirl.create(:book, user: user)
          fs = FactoryGirl.create(:file_set, user: user)
          book.ordered_members << fs
          book.save!

          get :manifest, id: book.id, format: :json

          expect(response).to be_success
          manifest = JSON.parse(response.body)
          expect(manifest["sequences"][0]["canvases"].length).to eq 1
        end
      end
    end
  end
end
