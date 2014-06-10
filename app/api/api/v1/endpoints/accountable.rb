class API::V1::Endpoints::Accountable < Grape::API
  include API::V1::Defaults

  namespace :accountable do
    helpers API::V1::Helpers::Shared

    before do
      authenticate!
    end

    namespace :my_account do
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
