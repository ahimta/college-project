module API
  class Routes < Grape::API
    mount V1::Routes
  end
end
