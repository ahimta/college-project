module Loginable
  extend ActiveSupport::Concern

  included do
    has_secure_password

    validates :full_name, :username, presence: true
  end
end
