class Account::AccountManager

  RecruiterRole = 0
  StudentRole = 1
  TeacherRole = 2
  AdminRole = 3

  def initialize(session)
    case session[:user_type]
    when Account::AccountManager::RecruiterRole
      @entity = API::V1::Entities::Recruiter::Account
      @model = Recruiter::Account
    else
      raise ArgumentError
    end

    @session = session
  end

  def role
    @role ||= @session[:user_type]
  end

  def entity
    @entity
  end

  def current_user
    @current_user ||= @model.find @session[:user_id] if @session[:user_id]
  end

  def login(username, password)
    @login ||= @model.where(username: username).first.try(:authenticate, password)
  end

  def logout
    @session.delete :user_type
    @session.delete :user_id
  end

  def username_available?(username)
    @taken ||= @model.where('lower(username) = ?', username.downcase).first
    not @taken
  end
end
