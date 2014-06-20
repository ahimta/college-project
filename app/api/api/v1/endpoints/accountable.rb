class API::V1::Endpoints::Accountable < Grape::API
  include API::V1::Defaults

  namespace :accountable do
    helpers API::V1::Params::Accountable
    helpers API::V1::Helpers::Shared

    desc 'logged in and non-logged in users'
    namespace do
      params do
        use :login
      end
      post :login do
        login = safe_params[:login]
        role  = safe_params[:role]

        user  = login(role, login[:username], login[:password])

        if user
          session[:user_id] = user.id
          session[:user_type] = role

          present :account, user, with: session_manager.entity
          present :role, role
        else
          error!('401', 401)
        end
      end
    end

    desc 'only logged in users'
    namespace do
      before do
        authenticate!
      end

      params do
        requires :username, type: String, presence: true
        requires :role, type: String, values: Account::Roles::AllRoles
      end
      head :username_available do
        error!('', 409) unless username_available?(params[:role], params[:username])
      end

      delete :logout do
        logout
      end

      namespace :my_account do
        get do
          present :account, current_user, with: session_manager.entity
          present :role, session_manager.role
        end

        delete do
          present :account, current_user.destroy, with: session_manager.entity
          present :role, session_manager.role

          logout
        end
      end
    end
  end
end
