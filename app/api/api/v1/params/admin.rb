module API::V1::Params::Admin
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
end
