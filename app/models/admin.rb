class Admin < ActiveRecord::Base
  default_scope { order('id desc') }

  has_secure_password

  validates :full_name, :username, presence: true
end
