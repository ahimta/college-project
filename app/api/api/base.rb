class API::Base < Grape::API
  mount API::V1::Base
end
