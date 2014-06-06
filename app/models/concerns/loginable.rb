module Loginable
  extend ActiveSupport::Concern

  AdminRole = 'admin'

  # Pre-assumptions:
  #   - session[:user_type] is not nil
  #   - session[:user_id] is not nil
  def self.current_user(session)
    Account::AccountManager.new(session).current_user
  end

  def self.username_available?(username, session)
    Account::AccountManager.new(session).username_available? username
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
