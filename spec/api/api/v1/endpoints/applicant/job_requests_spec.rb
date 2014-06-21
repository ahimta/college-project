require 'spec_helper'

describe API::V1::Endpoints::Applicant::JobRequests, type: :request do

  resource = 'applicant/job_requests'
  url = "/api/v1/#{resource}"
  model = Applicant::JobRequest
  entity = API::V1::Entities::Applicant::JobRequest

  args = [model, entity, resource]
  factories = {
    valid: [:applicant_job_request],
    invalid: [:invalid_applicant_job_request, :applicant_job_request_with_invalid_file]
  }

  context 'logged in' do
    let(:_login) {
      {login: {username: current_user.username, password: current_user.password}, role: role}
    }

    before { post '/api/v1/accountable/login', _login }

    context 'as an admin' do
      # WARNING: current_user name is not arbitrary, please don't change :-)
      let!(:current_user) { FactoryGirl.create :admin_account }

      let(:role) { Account::AccountManager::AdminRole }

      it_behaves_like "#{url} - logged in as an admin", args, factories
    end

    context 'as a recruiter' do
      # WARNING: current_user name is not arbitrary, please don't change :-)
      let!(:current_user) { FactoryGirl.create :recruiter_account }

      let(:role) { Account::AccountManager::RecruiterRole }

      it_behaves_like "#{url} - logged in as a recruiter", args, factories
    end
  end

  context 'not logged in' do
    it_behaves_like "#{url} - not logged in", (args + [factories])
  end
end
