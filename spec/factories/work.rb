require 'rails_helper'

FactoryGirl.define do
  factory :work do
    user
    sequence(:title) {|n| "I amm title nr. #{n}"}
    body "this is an example text baby!"
  end
end
