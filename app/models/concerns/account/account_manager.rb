module Account
  class AccountManager

    RecruiterRole = Roles::RecruiterRole
    StudentRole = Roles::StudentRole
    TeacherRole = Roles::TeacherRole
    AdminRole = Roles::AdminRole

    AllRoles = Roles::AllRoles

    def initialize(session)
      case session[:user_type]
      when RecruiterRole then @model  = Recruiter::Account
      when AdminRole then @model  = Admin::Account
      else raise ArgumentError
      end

      @session = session
    end

    def login(username, password)
      @login ||= @model.where(username: username).first.try(:authenticate, password)
    end

    def username_available?(username)
      !@model.where('lower(username) = ?', username.downcase).first
    end
  end
end
