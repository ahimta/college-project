class API::V1::Entities::Applicant::JobRequest < API::V1::Entities::Base

  expose :full_name, :phone, :address, :specialization, :degree

  expose :accepted do |applicant, _|
    applicant.accepted_status
  end
end
