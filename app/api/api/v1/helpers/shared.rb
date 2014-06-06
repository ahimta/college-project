module API::V1::Helpers::Shared

  def authenticate!
    error!('Unauthorized Access', 401) unless session[:user_id] and session[:user_type]
  end

  def current_user
    @current_user ||= Loginable.current_user(session) if session[:user_id] and session[:user_type]
  end

  def safe_params
    @safe_params ||= declared(params, include_missing: false)
  end

  def session
    @session ||= env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end
end
