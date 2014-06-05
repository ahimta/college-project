module Loginable
  extend ActiveSupport::Concern

  AdminRole = 'admin'

  # Pre-assumptions:
  #   - session[:user_type] is not nil
  #   - session[:user_id] is not nil
  def self.current_user(session)
    case session[:user_type]
    when AdminRole then Admin::Account.find session[:user_id]
    else raise ArgumentError
    end
  end

  included do
    has_secure_password

    validates :full_name, :username, presence: true

    def self.login(username, password)
      self.where(username: username).first.
        try(:authenticate, password)
    end
  end
end
