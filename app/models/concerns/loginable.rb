module Loginable
  extend ActiveSupport::Concern

  Admin = 'admin'

  included do
    has_secure_password

    validates :username, presence: true

    def self.login(username, password)
      self.where(username: username).first.
        try(:authenticate, password)
    end
  end
end
