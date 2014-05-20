class Applicant < ActiveRecord::Base
  default_scope { order('id desc') }

  validates :first_name, :last_name, :phone, :address, :specialization, :degree, presence: true
end
