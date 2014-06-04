class Admin < ActiveRecord::Base
  default_scope { order('id desc') }

  has_secure_password

  validates :full_name, :username, presence: true

  def self.login(username, password)
    self.where(username: username).first.
      try(:authenticate, password)
  end
end
