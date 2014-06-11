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
    end

    post do
    end

    route_param :id, type: Integer do
      get do
      end

      put do
      end

      delete do
      end
    end
  end
end
