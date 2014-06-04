class Admin < ActiveRecord::Base
  include Loginable

  default_scope { order('id desc') }

  validates :full_name, presence: true
end
