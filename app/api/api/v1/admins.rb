require_relative 'validators/confirmation'
require_relative 'validators/present'

module API::V1
  class Admins < Grape::API
    include Defaults

    resource :admins do
      helpers do
        params :admin do
          requires :admin, type: Hash do
            requires :full_name, type: String, present: true
            requires :username, type: String, present: true
            requires :password, type: String, present: true
            optional :password_confirmation, type: String, confirmation: 'password'
            optional :is_active, type: Boolean
          end
        end

        def safe_params
          @safe_params ||= declared(params, include_missing: false)[:admin]
        end
      end

      get do
        present Admin.all, with: Entities::Admin
      end

      params do
        requires :admin, type: Hash do
          requires :full_name, type: String, present: true
          requires :username, type: String, present: true
          requires :password, type: String, present: true
          optional :password_confirmation, type: String, confirmation: 'password'
          optional :is_active, type: Boolean
        end
      end
      post do
        present Admin.create!(safe_params), with: Entities::Admin
      end

      route_param :id, type: Integer, desc: 'admin id' do
        before do
          @admin = Admin.find params[:id]
        end

        desc 'Get an admin by id'
        get do
          present @admin, with: Entities::Admin
        end

        desc 'Update an admin by id'
        params do
          requires :admin, type: Hash do
            requires :full_name, type: String, present: true
            requires :username, type: String, present: true
            optional :password, type: String
            optional :password_confirmation, type: String, confirmation: 'password'
            optional :is_active, type: Boolean
          end
        end
        put do
          @admin.update! safe_params
          present @admin, with: Entities::Admin
        end

        desc 'Delete an admin by id'
        delete do
          present @admin.destroy, with: Entities::Admin
        end
      end
    end
  end
end
