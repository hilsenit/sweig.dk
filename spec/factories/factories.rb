FactoryGirl.define do

  factory :user do
    username "John"
    password  "password"
    sequence(:email) {|n| "facteory#{n}@mail.dk"}
  end

  


end