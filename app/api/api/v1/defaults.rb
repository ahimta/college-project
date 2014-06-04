module API::V1::Defaults
  extend ActiveSupport::Concern

  included do
    version 'v1', using: :path
    default_format :json
    format :json

    helpers do
      def safe_params
        @safe_params = declared(params, incude_missing: false)
      end

      def session
        @session ||= env[Rack::Session::Abstract::ENV_SESSION_KEY]
      end
    end



    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response(message: e.message, status: 404)
    end
  end
end
