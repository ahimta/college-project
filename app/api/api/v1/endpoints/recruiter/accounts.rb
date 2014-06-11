class API::V1::Endpoints::Recruiter::Accounts < Grape::API
  include API::V1::Defaults

  resource 'recruiter/accounts' do
    helpers API::V1::Params::Recruiter::Account
    helpers API::V1::Helpers::Shared
    helpers API::V1::Params::Shared
    helpers do
      def model
        @model ||= ::Recruiter::Account
      end

      def entity
        @entity ||= API::V1::Entities::Recruiter::Account
      end
    end

    desc 'only for logged in non-deletable recruiters'
    namespace do
      before do
        authenticate_admin!
      end

      desc 'Create a recruiter'
      params do
        use :recruiter_account_create
      end
      post do
        recruiter_account = safe_params[:recruiter_account]
        error!('', 409) unless account_manager.username_available? recruiter_account[:username]
        present :recruiter_account, model.create!(recruiter_account), with: entity
      end

      params do
        requires :username, type: String, presence: true
      end
      head :username_available do
        error!('', 409) unless account_manager.username_available? params[:username]
      end

      get do
        present :recruiter_accounts, model.all, with: entity
      end

      route_param :id, type: Integer, desc: 'recruiter id' do
        before do
          @record = model.find(params[:id])
        end

        desc 'Get a recruiter by id'
        get do
          present :recruiter_account, @record, with: entity
        end

        desc 'Update a recruiter by id'
        params do
          use :recruiter_account_update
        end
        put do
          @record.update! safe_params[:recruiter_account]
          present :recruiter_account, @record, with: entity
        end

        desc 'Delete a recruiter by id'
        delete do
          present :recruiter_account, @record.destroy, with: entity
        end
      end
    end
  end
end
