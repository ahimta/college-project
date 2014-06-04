module API::V1::SharedParams
  extend Grape::API::Helpers

  params :login do
    requires :login, type: Hash do
      requires :username, type: String, present: true
      requires :password, type: String, present: true
    end
  end
end
