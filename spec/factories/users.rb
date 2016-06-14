require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email-#{srand}@test.com" }
    password "password"
  end
end
