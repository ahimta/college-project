class API::V1::Base < Grape::API
  mount API::V1::Endpoints::Applicants
  mount API::V1::Endpoints::Admins
end
