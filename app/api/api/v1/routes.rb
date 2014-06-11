class API::V1::Routes < Grape::API
  mount API::V1::Endpoints::Applicant::Routes
  mount API::V1::Endpoints::Recruiter::Routes
  mount API::V1::Endpoints::Admin::Routes
  mount API::V1::Endpoints::Accountable
end
