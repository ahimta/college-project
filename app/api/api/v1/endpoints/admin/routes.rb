module API::V1::Endpoints::Admin
  class Routes < Grape::API
    mount Accounts
  end
end
