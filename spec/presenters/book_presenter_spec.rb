require 'spec_helper'

RSpec.describe BookConcerns::Presenters::BookPresenter do
  describe ".file_presenter_class" do
    it "is the locally scoped file presenter" do
      expect(described_class.file_presenter_class).to eq ::FileSetPresenter
    end
  end
end
