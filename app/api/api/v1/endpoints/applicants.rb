module API::V1
  class Endpoints::Applicants < Grape::API
    include Defaults

    resource :applicants do
      helpers API::V1::Params::Applicant
      helpers API::V1::Helpers::Shared

      desc 'Return all applicants.'
      get do
        present Applicant.all, with: Entities::Applicant
      end

      desc 'Create an applicant.'
      params do
        use :applicant
      end
      post do
        present Applicant.create!(safe_params[:applicant]), with: Entities::Applicant
      end

      route_param :id, type: Integer, desc: 'Applicant id.' do
        before do
          @applicant = Applicant.find(params[:id])
        end

        desc 'Get an applicant by id.'
        get do
          present @applicant, with: Entities::Applicant
        end

        desc 'Update an applicant.'
        params do
          use :applicant
        end
        put do
          @applicant.update!(safe_params[:applicant])
          present @applicant, with: Entities::Applicant
        end

        desc 'Delete an applicant.'
        delete do
          present @applicant.destroy, with: Entities::Applicant
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
end
