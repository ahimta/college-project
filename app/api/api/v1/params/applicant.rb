module API::V1::Params::Applicant
  extend Grape::API::Helpers

  params :applicant do
    requires :applicant, type: Hash do
      requires :first_name, type: String, present: true, desc: 'First name.'
      requires :last_name, type: String, present: true, desc: 'Last name'
      requires :phone, type: String, present: true, desc: 'Phone.'
      requires :address, type: String, present: true, desc: 'Address.'
      requires :specialization, type: String, present: true, desc: 'Specialization.'
      requires :degree, type: String, present: true, desc: 'Degree.'
    end
  end
end
