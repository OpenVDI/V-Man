require 'factory_girl'

FactoryGirl.define do

  factory :user do |f|
    f.sequence(:email) { |n| "user#{n}@example.com" }
    f.password 'password'
  end

end
