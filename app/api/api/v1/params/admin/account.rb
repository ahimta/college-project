require_relative '../../validators/confirmation'
require_relative '../../validators/present'

module API::V1::Params::Admin::Account
  extend Grape::API::Helpers

  params :admin do |options|
    requires :admin, type: Hash do
      requires :full_name, type: String, present: true
      requires :username, type: String, present: true

      case options[:action]
      when :create then requires :password, type: String, present: true
      when :update then optional :password, type: String
      else raise ArgumentError
      end

      optional :password_confirmation, type: String, confirmation: 'password'
      optional :is_active, type: Boolean
    end
  end


  params :admin_create do
    requires :admin_account, type: Hash do
      requires :full_name, type: String, present: true
      requires :username, type: String, present: true
      requires :password, type: String, present: true
      optional :password_confirmation, type: String, confirmation: 'password'
      optional :is_active
    end
  end

  params :admin_update do
    requires :admin_account, type: Hash do
      requires :full_name, type: String, present: true
      requires :username, type: String, present: true
      optional :password, type: String
      optional :password_confirmation, type: String, confirmation: 'password'
      optional :is_active
    end
  end
end
