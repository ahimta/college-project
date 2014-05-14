class V1::Applicants < Grape::API

  version 'v1', using: :path
  default_format :json
  format :json


  resource :applicants do
    desc 'Return all applicants.'
    get do
      present :applicants, Applicant.all
    end
  end
end
