# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :applicant do
    first_name "MyString"
    last_name "MyString"
    phone "MyString"
    address "MyString"
    specialization "MyString"
    degree "MyString"
  end
end