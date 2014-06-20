module API::V1::Helpers::Shared

  def authenticate!
    error!('Unauthorized Access', 401) unless current_user
  end

  def authenticate_admin!
    error!('Unauthorized Access', 401) unless current_user and
      session[:user_type] == Account::AccountManager::AdminRole
  end

  def authenticate_recruiter!
    error!('Unauthorized Access', 401) unless current_user and
      session[:user_type] == Account::AccountManager::RecruiterRole
  end

  def account_manager
    @account_manager ||= Account::AccountManager.new(session)
  end

  def current_user
    @current_user ||= account_manager.current_user if session[:user_type]
  end

  def safe_params
    @safe_params ||= declared(params, include_missing: false)
  end

  def session
    @session ||= env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end
end
