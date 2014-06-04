module API::V1::Helpers
  extend Grape::API::Helpers

  def safe_params
    @safe_params ||= declared(params, include_missing: false)
  end

  def session
    @session ||= env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end
end
