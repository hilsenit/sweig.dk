FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "John the #{n}!" }
    password  "password"
    sequence(:email) {|n| "example#{n}@mail.dk"}
    trait :works do
      after(:create) do |instance|
        create_list(:work, 3, user: instance)
      end
    end
  end

  factory :work do
    user
  	sequence(:title) {|n| "Mit eksempel nr: #{n} er smukt"}
  	body "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ea a ex, quaerat magni. Ut doloribus laboriosam, repudiandae accusantium reiciendis, ipsa consectetur minima modi, qui magnam quo eius impedit beatae optio. Hvis det er okay med dig. æøå"
  end 

end
