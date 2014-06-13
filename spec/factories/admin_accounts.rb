# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_account, class: 'Admin::Account' do
    sequence(:full_name) { |n| "admin_full_name#{n}" }
    sequence(:username)  { |n| "aDmiN_useRname#{n}" }
    sequence(:password)  { |n| "admin_password#{n}" }

    factory :admin_account_with_correct_password_confirmation do
      password_confirmation { password }
    end

    factory :admin_account_with_incorrect_password_confirmation do
      password_confirmation { password.upcase }
    end
  end

  factory :admin_account_without_full_name, class: 'Admin::Account' do
    sequence(:username)  { |n| "username#{n}" }
    sequence(:password)  { |n| "password#{n}" }
  end

  factory :admin_account_without_username, class: 'Admin::Account' do
    sequence(:full_name) { |n| "full_name#{n}" }
    sequence(:password)  { |n| "password#{n}" }
  end

  factory :admin_account_without_password, class: 'Admin::Account' do
    sequence(:full_name) { |n| "full_name#{n}" }
    sequence(:username)  { |n| "username#{n}" }
  end
end
