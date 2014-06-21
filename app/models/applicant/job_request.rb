class Applicant::JobRequest < ActiveRecord::Base
  default_scope { order('id desc') }

  _attachments = [:bachelor_certificate, :master_certificate, :doctorate_certificate, :cv]

  _attachments.each do |attachment|
    has_attached_file attachment
    validates_attachment attachment, size: { in: 0..1.megabyte },
      content_type: { content_type: 'application/pdf' }
  end

  validates :full_name, :phone, :address, :specialization, :degree, presence: true

  def accepted_status
    accepted = self.accepted

    if accepted.nil? then 'pending'
    elsif accepted then 'accepted'
    else 'rejected'
    end
  end
end
