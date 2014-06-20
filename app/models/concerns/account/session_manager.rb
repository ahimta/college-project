module Account
  class SessionManager

    def initialize(session)
      case session[:user_type]
      when Roles::RecruiterRole
        @entity = API::V1::Entities::Recruiter::Account
        @model  = Recruiter::Account
      when Roles::AdminRole
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
      @current_user ||= @model.where(id: @session[:user_id]).first if @session[:user_id]
    end
  end
end
