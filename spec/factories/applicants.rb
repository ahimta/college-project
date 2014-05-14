# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :applicant do
    sequence(:first_name)     { |n| "first_name#{n}" }
    sequence(:last_name)      { |n| "last_name#{n}" }
    sequence(:phone)          { |n| "phone#{n}" }
    sequence(:address)        { |n| "address#{n}" }
    sequence(:specialization) { |n| "specialization#{n}" }
    sequence(:degree)         { |n| "degree#{n}" }

    factory :invalid_applicant do
    	phone ''
    end
  end
end
