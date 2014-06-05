module API::V1
  class Routes < Grape::API
    mount Endpoints::Applicants
    mount Endpoints::Admin::Routes
  end
end
