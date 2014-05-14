class V1::Applicants < Grape::API

  version 'v1', using: :path
  default_format :json
  format :json


  resource :applicants do
    desc 'Return all applicants.'
    get do
      present :applicants, Applicant.all
    end

    desc 'Create an applicant'
    params do
      requires :applicant, type: Hash do
        requires :first_name, type: String
        requires :last_name, type: String
        requires :phone, type: String
        requires :address, type: String
        requires :specialization, type: String
        requires :degree, type: String
      end
    end
    post do
      applicant = Applicant.new params[:applicant]

      if applicant.save
        present :applicant, applicant
      else
        error!({errors: applicant.errors}, 400)
      end
    end
  end
end
