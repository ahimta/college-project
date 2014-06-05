class API::V1::Entities::Admin < API::V1::Entities::Base
  root :admin_accounts, :admin_account

  expose :full_name, :username, :deletable, :is_active
end
