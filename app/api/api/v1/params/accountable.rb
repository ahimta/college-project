require_relative '../validators/present'

module API::V1::Params::Accountable
  extend Grape::API::Helpers

  params :login do
    requires :role, type: String, values: Account::AccountManager::AllRoles

    requires :login, type: Hash do
      requires :username, type: String, present: true
      requires :password, type: String, present: true
    end
  end

  params :accountable_create do
    requires :full_name, type: String, present: true
    requires :username, type: String, present: true
    requires :password, type: String, present: true
    optional :password_confirmation, type: String, confirmation: 'password'
    optional :is_active
  end

  params :accountable_update do
    requires :full_name, type: String, present: true
    requires :username, type: String, present: true
    optional :password, type: String
    optional :password_confirmation, type: String, confirmation: 'password'
    optional :is_active
  end
end
