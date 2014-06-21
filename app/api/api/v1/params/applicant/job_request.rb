require_relative '../../validators/present'

module API::V1::Params::Applicant::JobRequest
  extend Grape::API::Helpers

  params :applicant_job_request do
    requires :applicant_job_request, type: Hash do
      requires :full_name, type: String, present: true, desc: 'Full name'
      requires :phone, type: String, present: true, desc: 'Phone.'
      requires :address, type: String, present: true, desc: 'Address.'
      requires :specialization, type: String, present: true, desc: 'Specialization.'
      requires :degree, type: String, present: true, desc: 'Degree.'

      optional :bachelor_certificate, type: Rack::Multipart::UploadedFile
      optional :master_certificate, type: Rack::Multipart::UploadedFile
      optional :doctorate_certificate, type: Rack::Multipart::UploadedFile
      optional :cv, type: Rack::Multipart::UploadedFile
    end
  end
end
