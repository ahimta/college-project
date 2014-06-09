class API::V1::Entities::Admin::Account < API::V1::Entities::Base
  expose :full_name, :username, :deletable, :is_active
end
