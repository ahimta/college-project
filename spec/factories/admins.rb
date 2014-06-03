# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    full_name "MyString"
    username "MyString"
    password_digest "MyString"
    deletable false
    is_active false
  end
end
