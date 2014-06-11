class API::V1::Endpoints::Accountable < Grape::API
  include API::V1::Defaults

  namespace :accountable do
    helpers API::V1::Params::Recruiter::Account
    helpers API::V1::Helpers::Shared

    namespace do
      params do
        use :login
        requires :role, type: String, values: Account::AccountManager::AllRoles
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

          present :account, user, with: entity
          present :role, role
        else
          error!('401', 401)
        end
      end
    end

    namespace :my_account do
      before do
        authenticate!
      end

      get do
        present :account, current_user, with: account_manager.entity
        present :role, account_manager.role
      end

      delete do
        present :account, current_user.destroy, with: account_manager.entity
        present :role, account_manager.role

        session.delete :user_type
        session.delete :user_id
      end
    end
  end
end
