require 'spec_helper'

describe API::V1::Endpoints::Applicant::JobRequests do

  resource = 'applicant/job_requests'
  url = "/api/v1/#{resource}"
  model = Applicant::JobRequest
  entity = API::V1::Entities::Applicant::JobRequest

  args = [model, entity, resource]
  factories = {valid: [:applicant_job_request], invalid: [:invalid_applicant_job_request]}

  context 'logged in' do
    let(:_login) {
      {login: {username: _account.username, password: _account.password}, role: role}
    }

    before { post '/api/v1/accountable/login', _login }

    pending 'as an admin'
    context 'as a recruiter' do
      let!(:_account) { FactoryGirl.create :recruiter_account }

      let(:role) { Account::AccountManager::RecruiterRole }

      it_behaves_like "#{url} - logged_in as a recruiter", args, factories
    end
  end

  context 'not logged in' do
    it_behaves_like "#{url} - not_logged_in", (args + [factories])
  end
end
