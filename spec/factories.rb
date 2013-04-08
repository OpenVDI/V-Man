require 'factory_girl'

FactoryGirl.define do

  factory :user do |f|
    f.sequence(:email) { |n| "user#{n}@example.com" }
    f.password 'password'
    f.roles ['user']
  end

  factory :admin, class: 'User' do |f|
    f.sequence(:email) { |n| "admin#{n}@example.com" }
    f.password 'password'
    f.roles ['admin']
  end

  factory :template do |f|
    f.name 'image of foo distro'
    f.description 'description of foo'
    f.format 'qcow2'
    f.image Rails.root.join('images', 'test.qcow2').to_s
  end

end
