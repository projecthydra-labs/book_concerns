FactoryGirl.define do
  # The ::FileSet model is defined in spec/internal/app/models by the
  # curation_concerns:install generator.
  factory :book, class: Book do
    transient do
      title ["Test Book"]
      user { FactoryGirl.create(:user) }
    end

    after(:build) do |file, evaluator|
      file.apply_depositor_metadata(evaluator.user.user_key)
    end
  end
end
