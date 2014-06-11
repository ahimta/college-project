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
end
