class API::V1::Entities::Applicant < API::V1::Entities::Base
  root :applicants, :applicant

  expose :first_name, :last_name, :phone, :address, :specialization, :degree
end
