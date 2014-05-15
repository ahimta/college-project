module API::V1::Defaults
  extend ActiveSupport::Concern

  included do
    version 'v1', using: :path
    default_format :json
    format :json

    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response(message: e.message, status: 404)
    end
  end
end
