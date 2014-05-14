class V1::Present < Grape::Validations::Validator
  def validate_param!(attr_name, params)
    unless params[attr_name].present?
      raise Grape::Exceptions::Validation, param: @scope.full_name(attr_name), message: "can't be blank"
    end
  end
end

class V1::Applicants < Grape::API

  version 'v1', using: :path
  default_format :json
  format :json


  resource :applicants do
    helpers do
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

      def safe_params
        attrs = params[:applicant]
        @safe_params ||= {first_name: attrs[:first_name], last_name: attrs[:last_name],
          phone: attrs[:phone], address: attrs[:address], specialization: attrs[:specialization],
          degree: attrs[:degree]}
      end
    end

    desc 'Return all applicants.'
    get do
      present :applicants, Applicant.all
    end

    desc 'Create an applicant.'
    params do
      use :applicant
    end
    post do
      present :applicant, Applicant.create!(safe_params)
    end
  end
end
