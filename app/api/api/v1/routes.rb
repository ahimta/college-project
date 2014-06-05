module API::V1
  class Routes < Grape::API
    mount Endpoints::Applicant::Routes
    mount Endpoints::Admin::Routes
  end
end
