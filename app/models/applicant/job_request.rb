class Applicant::JobRequest < ActiveRecord::Base
  default_scope { order('id desc') }

  validates :full_name, :phone, :address, :specialization, :degree, presence: true

  def accepted_status
    accepted = self.accepted

    if accepted.nil? then 'pending'
    elsif accepted then 'accepted'
    else 'rejected'
    end
  end
end
