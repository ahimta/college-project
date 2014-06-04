# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    sequence(:full_name) { |n| "full_name#{n}" }
    sequence(:username)  { |n| "username#{n}" }
    sequence(:password)  { |n| "password#{n}" }

    factory :admin_with_correct_password_confirmation do
      password_confirmation { password }
    end

    factory :admin_with_incorrect_password_confirmation do
      password_confirmation { password.upcase }
    end
  end

  factory :admin_without_full_name, class: Admin do
    sequence(:username)  { |n| "username#{n}" }
    sequence(:password)  { |n| "password#{n}" }
  end

  factory :admin_without_username, class: Admin do
    sequence(:full_name) { |n| "full_name#{n}" }
    sequence(:password)  { |n| "password#{n}" }
  end

  factory :admin_without_password, class: Admin do
    sequence(:full_name) { |n| "full_name#{n}" }
    sequence(:username)  { |n| "username#{n}" }
  end
end
