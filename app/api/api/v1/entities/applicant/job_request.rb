class API::V1::Entities::Applicant::JobRequest < API::V1::Entities::Base

  expose :full_name, :phone, :address, :specialization, :degree

  expose :accepted do |applicant, _|
    applicant.accepted_status
  end

  expose :bachelor_certificate_url do |applicant, _|
    applicant.bachelor_certificate.url
  end
  expose :master_certificate_url do |applicant, _|
    applicant.master_certificate.url
  end
  expose :doctorate_certificate_url do |applicant, _|
    applicant.doctorate_certificate.url
  end
  expose :cv_url do |applicant, _|
    applicant.cv.url
  end
end
