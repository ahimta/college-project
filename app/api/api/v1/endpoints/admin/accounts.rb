class API::V1::Endpoints::Admin::Accounts < Grape::API
  include API::V1::Defaults

  resource 'admin/accounts' do
    helpers API::V1::Params::Admin::Account
    helpers API::V1::Helpers::Shared
    helpers API::V1::Params::Shared
    helpers do
      def model
        @model ||= ::Admin::Account
      end

      def entity
        @entity ||= API::V1::Entities::Admin::Account
      end
    end

    before do
      authenticate_admin!
    end

    params do
      use :admin_account_update
    end
    put :my_account do
      account  = safe_params[:admin_account]
      username = account[:username]

      unless username == current_user.username or account_manager.username_available? username
        error('', 409)
      else
        current_user.update! account

        present :account, account, with: entity
        present :role, Account::AccountManager::AdminRole
      end
    end

    get do
      present :admin_accounts, model.all, with: entity
    end

    params do
      use :admin_account_create
    end
    post do
      admin_account = safe_params[:admin_account]

      error!('', 409) unless account_manager.username_available? admin_account[:username]

      present :admin_account, model.create!(admin_account), with: entity
    end

    route_param :id, type: Integer do
      namespace do
        before do
          @record = model.find params[:id]
        end

        get do
          present :admin_account, @record, with: entity
        end
      end

      namespace do
        before do
          error!('', 401)
        end

        params do
          use :admin_account_update
        end
        put do
        end

        delete do
        end
      end
    end
  end
end
