require 'rails_helper'

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "Wan Halllen nr. #{n}"}
    sequence(:email) {|n| "example#{n}@gmail.com"}
    password "password"

    trait :admin do
      admin true
    end

    trait :works do
      after(:create) do |user_instance|
        create_list(:work, 3, user: user_instance)
      end
    end
  end
end
