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
      before do
        @record = model.find params[:id]
      end

      get do
        present :admin_account, @record, with: entity
      end

      namespace do
        before do
          error!('', 401) unless current_user.id == @record.id
        end

        params do
          use :admin_account_update
        end
        put do
          @record.update! safe_params[:admin_account]
          present :admin_account, @record, with: entity
        end

        delete do
          error!('', 401)
        end
      end
    end
  end
end
