module API::V1
  class Endpoints::Admins < Grape::API
    include Defaults

    resource :admins do
      helpers API::V1::Helpers::Shared
      helpers API::V1::Params::Shared
      helpers API::V1::Params::Admin

      namespace do
        params do
          use :login
        end
        post :login do
          user = safe_params[:login]
          admin = Admin::Account.login(user[:username], user[:password])

          if admin
            session[:user_id] = admin.id
            session[:user_type] = Loginable::AdminRole
          else
            error!('401', 401)
          end
        end
      end

      namespace do
        before do
          authenticate!
        end

        get do
          present Admin::Account.all, with: Entities::Admin
        end

        desc 'Create an admin'
        params do
          use :admin_create
        end
        post do
          present Admin::Account.create!(safe_params[:admin_account]), with: Entities::Admin
        end

        desc 'Log out an admin'
        delete :logout do
          session.delete :user_type
          session.delete :user_id
        end

        route_param :id, type: Integer, desc: 'admin id' do
          before do
            @admin = Admin::Account.find(params[:id])
          end

          desc 'Get an admin by id'
          get do
            present @admin, with: Entities::Admin
          end

          desc 'Update an admin by id'
          params do
            use :admin_update
          end
          put do
            @admin.update! safe_params[:admin_account]
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
end
