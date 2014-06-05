class API::V1::Entities::Applicant < API::V1::Entities::Base
  root :applicant_job_requests, :applicant_job_requests

  expose :full_name, :phone, :address, :specialization, :degree

  expose :accepted do |applicant, _|
    applicant.accepted_status
  end
end
