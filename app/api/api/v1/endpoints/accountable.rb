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
        return if session[:user_type]

        login = safe_params[:login]
        role  = safe_params[:role]

        user  = Account::AccountManager.login(username: login[:username],
          password: login[:password], role: role)

        if user
          session[:user_id] = user.id
          session[:user_type] = role

          present :account, user, with: account_manager.entity
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

      delete :logout do
        account_manager.logout
      end

      namespace :my_account do
        get do
          present :account, current_user, with: account_manager.entity
          present :role, account_manager.role
        end

        delete do
          present :account, current_user.destroy, with: account_manager.entity
          present :role, account_manager.role

          account_manager.logout
        end
      end
    end
  end
end