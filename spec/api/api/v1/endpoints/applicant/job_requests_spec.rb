require 'spec_helper'

describe API::V1::Endpoints::Applicant::JobRequests do

  resource = 'applicant/job_requests'
  url = "/api/v1/#{resource}"
  model = Applicant::JobRequest
  entity = API::V1::Entities::Applicant::JobRequest

  recruiter_role = Account::AccountManager::RecruiterRole

  args = [model, entity, resource]
  factories = {valid: [:applicant_job_request], invalid: [:invalid_applicant_job_request]}

  context 'logged in' do
    pending 'as admin'
    context 'as recruiter' do
      let!(:_recruiter) { FactoryGirl.create :recruiter_account }
      let!(:_login) {
        {login: {username: _recruiter.username, password: _recruiter.password}, role: recruiter_role}
      }

      before { post '/api/v1/accountable/login', _login }

      it_behaves_like "#{url} - logged_in", args, factories
    end
  end

  context 'not logged in' do
    it_behaves_like "#{url} - not_logged_in", (args + [factories])
  end
end
