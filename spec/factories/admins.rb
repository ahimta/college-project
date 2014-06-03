# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    sequence(:full_name) { |n| "full_name#{n}" }
    sequence(:username) { |n| "username#{n}" }
    sequence(:password) { |n| "password#{n}" }
  end
end
