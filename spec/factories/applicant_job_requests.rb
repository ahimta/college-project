# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :applicant, class: 'Applicant::JobRequest' do
    sequence(:specialization) { |n| "specialization#{n}" }
    sequence(:full_name)      { |n| "full_name#{n}" }
    sequence(:address)        { |n| "address#{n}" }
    sequence(:degree)         { |n| "degree#{n}" }
    sequence(:phone)          { |n| "phone#{n}" }

    factory :invalid_applicant do
      phone ''
    end
  end
end
