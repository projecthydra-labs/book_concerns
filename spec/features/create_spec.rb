require 'spec_helper'

feature "creating a book as a user" do
  background do
    login_as FactoryGirl.create(:user), scope: :user
  end
  scenario "a user can create a book" do
    visit root_path
    click_link "New Book"
    fill_in "Title", with: "Test Title"
    click_button "Create Book"

    expect(page).to have_selector "h1", text: "Test Title"
  end
end
