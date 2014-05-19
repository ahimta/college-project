class API::V1::Entities::Applicant < API::V1::Entities::Base
  root :applicants, :applicant

  expose :first_name, :last_name, :phone, :address, :specialization, :degree

  expose :accepted do |applicant, _|
    accepted = applicant.accepted

    if accepted.nil? then 'pending'
    elsif accepted then 'accepted'
    else 'rejected'
    end
  end
end
