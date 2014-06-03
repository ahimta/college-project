class API::V1::Applicants < Grape::API
  include API::V1::Defaults
  include API::V1::Validators


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
        @safe_params ||= declared(params, include_missing: false)[:applicant]
      end
    end

    desc 'Return all applicants.'
    get do
      present Applicant.all, with: API::V1::Entities::Applicant
    end

    desc 'Create an applicant.'
    params do
      use :applicant
    end
    post do
      present Applicant.create!(safe_params), with: API::V1::Entities::Applicant
    end

    route_param :id, type: Integer, desc: 'Applicant id.' do
      before do
        @applicant = Applicant.find(params[:id])
      end

      desc 'Get an applicant by id.'
      get do
        present @applicant, with: API::V1::Entities::Applicant
      end

      desc 'Update an applicant.'
      params do
        use :applicant
      end
      put do
        @applicant.update! safe_params

        present @applicant, with: API::V1::Entities::Applicant
      end

      desc 'Delete an applicant.'
      delete do
        present @applicant.destroy, with: API::V1::Entities::Applicant
      end

      desc 'Accept an applicant.'
      put 'accept' do
        @applicant.update! accepted: true unless @applicant.accepted?
      end

      desc 'Reject an applicant.'
      put '/reject' do
        accepted = @applicant.accepted

        @applicant.update! accepted: false if accepted.nil? or accepted
      end
    end
  end
end
