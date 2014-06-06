class API::V1::Endpoints::Applicant::JobRequests < Grape::API
  include API::V1::Defaults

  resource 'applicant/job_requests' do
    helpers API::V1::Params::Applicant::JobRequest
    helpers API::V1::Helpers::Shared
    helpers do
      def model
        @model ||= ::Applicant::JobRequest
      end

      def entity
        @entity ||= API::V1::Entities::Applicant::JobRequest
      end
    end

    namespace do
      desc 'Create an applicant.'
      params do
        use :applicant_job_request
      end
      post do
        present model.create!(safe_params[:applicant_job_request]), with: entity
      end
    end

    namespace do
      before do
        authenticate_admin!
      end

      desc 'Return all applicants.'
      get do
        present model.all, with: entity
      end

      route_param :id, type: Integer, desc: 'Applicant id.' do
        before do
          @record = model.find(params[:id])
        end

        desc 'Get an applicant by id.'
        get do
          present @record, with: entity
        end

        desc 'Update an applicant.'
        params do
          use :applicant_job_request
        end
        put do
          @record.update!(safe_params[:applicant_job_request])
          present @record, with: entity
        end

        desc 'Delete an applicant.'
        delete do
          present @record.destroy, with: entity
        end

        desc 'Accept an applicant.'
        put 'accept' do
          @record.update! accepted: true unless @record.accepted?
        end

        desc 'Reject an applicant.'
        put '/reject' do
          accepted = @record.accepted
          @record.update! accepted: false if accepted.nil? or accepted
        end
      end
    end
  end
end
