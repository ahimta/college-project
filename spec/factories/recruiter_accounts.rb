# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recruiter_account, class: 'Recruiter::Account' do
    sequence(:full_name) { |n| "recruiter_full_name#{n}" }
    sequence(:username)  { |n| "reCruiTer_userName#{n}" }
    sequence(:password)  { |n| "recruiter_password#{n}" }

    factory :recruiter_account_with_correct_password_confirmation do
      password_confirmation { password }
    end

    factory :recruiter_account_with_incorrect_password_confirmation do
      password_confirmation { password.upcase }
    end
  end

  factory :recruiter_account_without_full_name, class: 'Recruiter::Account' do
    sequence(:username)  { |n| "username#{n}" }
    sequence(:password)  { |n| "password#{n}" }
  end

  factory :recruiter_account_without_username, class: 'Recruiter::Account' do
    sequence(:full_name) { |n| "full_name#{n}" }
    sequence(:password)  { |n| "password#{n}" }
  end

  factory :recruiter_account_without_password, class: 'Recruiter::Account' do
    sequence(:full_name) { |n| "full_name#{n}" }
    sequence(:username)  { |n| "username#{n}" }
  end
end
