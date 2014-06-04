class API::V1::Entities::Admin < API::V1::Entities::Base
  root :admins, :admin

  expose :full_name, :username, :deletable, :is_active
end
