class Admin::Account < ActiveRecord::Base
  include Loginable

  default_scope { order('id desc') }
end
