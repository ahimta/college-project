# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_account, :class => 'Admin::Account' do
    full_name "MyString"
    username "MyString"
    password_digest "MyString"
    is_active false
  end
end
