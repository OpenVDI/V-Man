require 'factory_girl'

FactoryGirl.define do

  factory :user do |f|
    f.sequence(:email) { |n| "user#{n}@example.com" }
    f.password 'password'
    f.roles ['user']
  end

  factory :admin, class: 'User' do |f|
    f.sequence(:email) { |n| "user#{n}@example.com" }
    f.password 'password'
    f.roles ['admin']
  end


end
