require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |_n| "email-#{srand}@test.com" }
    password "password"
  end
end
