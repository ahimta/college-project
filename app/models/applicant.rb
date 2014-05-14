class Applicant < ActiveRecord::Base
  validates :first_name, :last_name, :phone, :address, :specialization, :degree, presence: true
end
