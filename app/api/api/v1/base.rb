class API::V1::Base < Grape::API
  mount API::V1::Applicants
end
