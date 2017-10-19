require 'rails_helper'

FactoryGirl.define do

  factory :saved_work do
    user
    work
  end

end
