module API::V1::Endpoints::Applicant
  class Routes < Grape::API
    mount JobRequests
  end
end
