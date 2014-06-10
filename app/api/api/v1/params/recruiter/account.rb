require_relative '../../validators/confirmation'
require_relative '../../validators/present'

module API::V1::Params::Recruiter::Account
  extend Grape::API::Helpers

  params :recruiter_account_create do
    requires :recruiter_account, type: Hash do
      requires :full_name, type: String, present: true
      requires :username, type: String, present: true
      requires :password, type: String, present: true
      optional :password_confirmation, type: String, confirmation: 'password'
      optional :is_active
    end
  end

  params :recruiter_account_update do
    requires :recruiter_account, type: Hash do
      requires :full_name, type: String, present: true
      requires :username, type: String, present: true
      optional :password, type: String
      optional :password_confirmation, type: String, confirmation: 'password'
      optional :is_active
    end
  end
end
