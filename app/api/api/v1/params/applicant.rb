require_relative '../validators/present'

module API::V1::Params::Applicant
  extend Grape::API::Helpers

  params :applicant do
    requires :applicant, type: Hash do
      requires :full_name, type: String, present: true, desc: 'Full name'
      requires :phone, type: String, present: true, desc: 'Phone.'
      requires :address, type: String, present: true, desc: 'Address.'
      requires :specialization, type: String, present: true, desc: 'Specialization.'
      requires :degree, type: String, present: true, desc: 'Degree.'
    end
  end
end
