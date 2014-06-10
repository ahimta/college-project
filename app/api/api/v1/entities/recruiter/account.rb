class API::V1::Entities::Recruiter::Account < API::V1::Entities::Base
  expose :full_name, :username, :deletable, :is_active
end
