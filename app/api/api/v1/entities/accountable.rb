module API::V1::Entities
  class Accountable < Base
    expose :full_name, :username, :is_active
  end
end
