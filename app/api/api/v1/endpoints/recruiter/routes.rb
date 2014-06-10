module API::V1::Endpoints::Recruiter
  class Routes < Grape::API
    mount Accounts
  end
end
