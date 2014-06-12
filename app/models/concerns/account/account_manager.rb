class Account::AccountManager

  RecruiterRole = 'recruiter'
  StudentRole = 'student'
  TeacherRole = 'teacher'
  AdminRole = 'admin'

  AllRoles = [RecruiterRole, StudentRole, TeacherRole, AdminRole]

  def self.login(username:, password:, role:)
    raise ArgumentError unless AllRoles.include? role

    self.new(user_type: role).login(username, password)
  end

  def self.username_available?(username:, role:)
    self.new(user_type: role).username_available? username
  end

  def initialize(session)
    case session[:user_type]
    when RecruiterRole
      @entity = API::V1::Entities::Recruiter::Account
      @model  = Recruiter::Account
    when AdminRole
      @entity = API::V1::Entities::Admin::Account
      @model  = Admin::Account
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

  def logout
    @session.delete :user_type
    @session.delete :user_id
  end

  def login(username, password)
    @login ||= @model.where(username: username).first.try(:authenticate, password)
  end

  def username_available?(username)
    @taken ||= @model.where('lower(username) = ?', username.downcase).first
    not @taken
  end
end
