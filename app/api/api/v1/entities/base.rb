class API::V1::Entities::Base < Grape::Entity
  expose :id, :created_at, :updated_at
end
